module 0xda807ec23b65a17835158fde358bc3759772751e5bd834618562072673c1f07a::mdoge {
    struct MDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOGE>(arg0, 9, b"MDOGE", b"MarsDoge", x"546865206e6578742065766f6c7574696f6e206f66206d656d6520746f6b656e732c206275696c74206f6e2053554920746f2063656c656272617465207468652062656c6f76656420446f6765206d6173636f7420616e6420456c6f6e204d75736be280997320766973696f6e206f66207370616365206578706c6f726174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f4484b9-8347-40b0-b8b2-2c87830918b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

