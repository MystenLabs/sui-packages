module 0xc40e0e86e1467ae1e49b678eb7fdda7d52f05a805e8eb9f3b5b5c3a131dafc2e::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"BURN", b"SUI BURN", b"WE BUY, WE BURN, WE MOON!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/61_C_p2_GV_400x400_96fd2edc92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURN>>(v1);
    }

    // decompiled from Move bytecode v6
}

