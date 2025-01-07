module 0x743e3c67338d1d9be2419025b101ff3498efdaa021287e43935ae88fa21adf9f::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"SONIC", x"5468652066617374657374206865646765686f6720636f6d657320746f205375692e205175696c6c2d69616e742053706565642c2041646f7261626c65204d696768742120f09fa694e29aa1efb88f2047657420796f75722068616e6473206f6e20746865206375746573742c206661737465737420667269656e642061726f756e642122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731040269597.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

