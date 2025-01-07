module 0x85bf2399313c40599b534e6adb4308d0e84c5e47f082d3468f1ea4578b20a38a::skop {
    struct SKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOP>(arg0, 6, b"SKOP", b"SkullofpepeSui", b"$SKOP on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000361_d968424171.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

