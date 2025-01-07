module 0xe410ba6c5b36eca417565b9698bc8ae4fce814baf57db21b299ee44922a0aa39::senk {
    struct SENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENK>(arg0, 6, b"SENK", b"Senk Token", x"53656e6b20546f6b656e206973204261636b5374726f6e676572205468616e204576657221200a41667465722068697474696e6720616e20616c6c2d74696d652068696768206f662024344d2c2053656e6b206973206d616b696e672061207374726f6e6720636f6d656261636b2e20446576656c6f706572732061726520726561647920746f206d616b652053656e6b2074686520636f6f6c657374207365616c206f6e2053554920616761696e2e20446f6e74206d69737320796f7572206368616e636520746f206765742053656e6b2061742061206261726761696e206265666f726520697420736f61727321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726079406000_bf89bf43dbc6ff64bc210cc79959d78f_09645742b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENK>>(v1);
    }

    // decompiled from Move bytecode v6
}

