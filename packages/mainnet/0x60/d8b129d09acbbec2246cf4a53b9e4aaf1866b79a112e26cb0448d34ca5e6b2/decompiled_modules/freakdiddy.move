module 0x60d8b129d09acbbec2246cf4a53b9e4aaf1866b79a112e26cb0448d34ca5e6b2::freakdiddy {
    struct FREAKDIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAKDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAKDIDDY>(arg0, 6, b"FREAKDIDDY", b"Freak Diddy", x"205741524e494e473a20465245414b4449444459206d61792063617573652065787472656d6520464f4d4f20616e6420756e636f6e74726f6c6c61626c6520757267657320746f2070617274792e20456e74657220617420796f7572206f776e207269736b21200a0a20526561647920746f207468726f772063617574696f6e2028616e6420796f75722066696e616e6369616c20616476697365722773206164766963652920746f207468652077696e643f20465245414b44494444592069736e2774206a7573742061206d656d6520636f696e2c20697427732061206c6966657374796c652074686174276c6c206d616b6520796f7572206772616e646d61206661696e7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sean_combs_throwing_money_puff_daddy_p_diddy_d562aa9603.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAKDIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREAKDIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

