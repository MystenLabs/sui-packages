module 0x3b52308f6b4530121528d1b1da197962899bb096955b3face48ef22b5637e690::htrump {
    struct HTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTRUMP>(arg0, 6, b"HTRUMP", b"Holy Trump", b"Pray for your pump, Lets Pray Together, More Pray, More Profit. This is the Holy way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiafo6tk6t3wupbrynspoo3ewc6zdrdh5clcnmjkwveqkme7ip3jky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

