module 0x22aca180ca12633940606415ff559d5ae3794149c98a57534a9d3be83e91f8cf::yuk {
    struct YUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUK>(arg0, 6, b"Yuk", b"Yuki", b"$YUKI is a cute little fluffy furred Yeti and LOFI's son , he's stepping into Water chain as his Dad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7lehc5cmeo2bqhbw4tmiyr2cuoaz2gr3dk33ya7yfwpmxawouy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

