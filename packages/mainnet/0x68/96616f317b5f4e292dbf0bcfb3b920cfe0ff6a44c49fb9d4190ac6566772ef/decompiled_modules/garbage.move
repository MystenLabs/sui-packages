module 0x6896616f317b5f4e292dbf0bcfb3b920cfe0ff6a44c49fb9d4190ac6566772ef::garbage {
    struct GARBAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARBAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARBAGE>(arg0, 6, b"GARBAGE", b"TRUMP TRASH", b"Crooked Joe IS THE Garbage.  Lyin' Kamala, You're Fired! MAGA!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2dai_creation_a0fe4dfc9a6483c9cd4b9fe73308a5ed_8e83748114.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARBAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARBAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

