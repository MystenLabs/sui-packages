module 0xb28865d56d1786d1fdcd07c2506a2c4b7e7028f7afb7617ac8fc0035274ba9d6::suitar {
    struct SUITAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAR>(arg0, 6, b"SUITAR", b"SUI AVATAR", b"Avatar Sui making a run for more za bro are you good?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3_f68d041bd6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

