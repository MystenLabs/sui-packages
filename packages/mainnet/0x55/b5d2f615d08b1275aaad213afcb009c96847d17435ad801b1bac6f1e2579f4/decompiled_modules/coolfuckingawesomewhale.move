module 0x55b5d2f615d08b1275aaad213afcb009c96847d17435ad801b1bac6f1e2579f4::coolfuckingawesomewhale {
    struct COOLFUCKINGAWESOMEWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLFUCKINGAWESOMEWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLFUCKINGAWESOMEWHALE>(arg0, 6, b"COOLFUCKINGAWESOMEWHALE", b"COOLFUCKINGAWESOMEWHALE on Sui", x"5468697320636f696e206973206d61646520666f72207468652062696720706c6179657273206279207468652062696720706c61796572732e204974732074696d6520666f722065766572796f6e6520746f207377696d2077697468207468652062696720666973682e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wha_87f16dc405.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLFUCKINGAWESOMEWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLFUCKINGAWESOMEWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

