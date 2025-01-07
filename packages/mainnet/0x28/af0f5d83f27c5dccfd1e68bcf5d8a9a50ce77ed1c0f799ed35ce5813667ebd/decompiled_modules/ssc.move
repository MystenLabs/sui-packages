module 0x28af0f5d83f27c5dccfd1e68bcf5d8a9a50ce77ed1c0f799ed35ce5813667ebd::ssc {
    struct SSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSC>(arg0, 6, b"SSC", b"Sui Sauce", b"Sui Sauce yum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/95a2b507_73e2_4e18_9007_7eaeb02a8bd1_1_c52f2ae02cf4278ce4509f0437d252eb_dac57e0bdc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

