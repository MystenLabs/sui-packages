module 0xe1ef769da5115dcce43b67191a1e0345302057dc0656ba1a1e0383d9fcf735ed::sgrd {
    struct SGRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGRD>(arg0, 6, b"SGRD", b"SuiGuardProtection", b"SGRD is a safeguard that maintains stability and strength in the sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055261_4d96d4fc85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

