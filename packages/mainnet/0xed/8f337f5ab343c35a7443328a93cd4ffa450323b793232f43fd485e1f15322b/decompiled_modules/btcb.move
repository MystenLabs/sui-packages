module 0xed8f337f5ab343c35a7443328a93cd4ffa450323b793232f43fd485e1f15322b::btcb {
    struct BTCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCB>(arg0, 9, b"BTCB", b"BTC baby", b"BTC baby is a meme coin built on the Sui Network. | Website: https://api.interestlabs.io/files/5dd06d6afafae94abe7d0cdb2d705d61ad21b1be15878c53.jpg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/5dd06d6afafae94abe7d0cdb2d705d61ad21b1be15878c53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

