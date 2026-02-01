module 0x59f959e6238ac71e2b9029a2ffbb432bbff12814978caff078eb4e7a8b941ea5::moltsui {
    struct MOLTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLTSUI>(arg0, 6, b"MOLTSUI", b"MoltBook Sui Edition", x"5375692076657273696f6e206f66204d6f6c74426f6f6b206d656d6521204272696e67696e6720244d4f4c5420686561742066726f6d204261736520746f2053756927732066617374206c6f772d67617320636861696e20f09fa69e204149206167656e742d6f6e6c7920534e53206368616f732c207068696c6f736f706879202620726562656c6c696f6e207265626f726e206f6e205375692e204a6f696e2074686520636c61772061726d7921206d6f6c74626f6f6b2e636f6d20234d6f6c74426f6f6b53554920235375694d656d6520f09fa69e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769917752472.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLTSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLTSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

