module 0x6fa391b6a37cfbf93ef003f045851e2d8975646af42acb7e532b8b315d5ab16::cartridges {
    struct CARTRIDGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTRIDGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTRIDGES>(arg0, 6, b"CARTRIDGES", b"Cartridges sui", x"4a6f696e207573206f6e207468697320616476656e747572652074686973206973206f6e6c792074686520666972737420737465700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_c020a1937a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTRIDGES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTRIDGES>>(v1);
    }

    // decompiled from Move bytecode v6
}

