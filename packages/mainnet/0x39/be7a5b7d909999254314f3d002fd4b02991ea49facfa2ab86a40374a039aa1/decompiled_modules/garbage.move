module 0x39be7a5b7d909999254314f3d002fd4b02991ea49facfa2ab86a40374a039aa1::garbage {
    struct GARBAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARBAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARBAGE>(arg0, 6, b"GARBAGE", b"TRUMP TRASH", b"Crooked Joe IS THE Garbage.  Lyin' Kamala, You're Fired! MAGA!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2dai_creation_a0fe4dfc9a6483c9cd4b9fe73308a5ed_f18af8c2b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARBAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARBAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

