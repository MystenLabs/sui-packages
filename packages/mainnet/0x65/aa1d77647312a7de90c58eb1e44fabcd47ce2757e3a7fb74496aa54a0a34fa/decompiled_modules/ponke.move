module 0x65aa1d77647312a7de90c58eb1e44fabcd47ce2757e3a7fb74496aa54a0a34fa::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 6, b"PONKE", b"PONKEONSUI", x"45584348414e4745530a506f6e6b6520697320617661696c61626c6520666f722074726164696e67206f6e206d616a6f722065786368616e6765732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ponke_e3e76e09da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

