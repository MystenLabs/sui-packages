module 0x9443b1ef5d960656e74b2408f5ed0171b72d9f666732b820178c6a2bb7a9af17::bbn {
    struct BBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBN>(arg0, 6, b"BBN", b"Bitbunny on SUI", x"42697462756e6e792077696c6c206d616b65206d656d6573207361666520616e6420677265617420616761696e206f6e2074686520535549206e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FA_Og_Feyl_400x400_bfaf16906f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

