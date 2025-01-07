module 0x24a54e8149184bce26b1af89053d3ca26ff93fe39358ac9b9c3be6ea455fc24e::flexmeme {
    struct FLEXMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEXMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEXMEME>(arg0, 6, b"FLEXMEME", b"FlexYourMeme.Com", x"466c6578596f75724d656d652e636f6d2069732074686520756c74696d617465206875622077686572652068756d6f72206d6565747320637265617469766974792c20616e64206d656d65732072756c652074686520776f726c642120f09f9a8020506f776572656420627920612076696272616e7420636f6d6d756e69747920616e642063727970746f20656e657267792c206974e28099732074686520676f2d746f2073706f7420666f722073686f77636173696e672065706963206d656d65732c20737061726b696e67206c617567687465722c20616e6420737072656164696e6720766972616c2076696265732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736058311765.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLEXMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEXMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

