module 0x48cf077d51c679f49128f6360f0ba9cb75c2c391341db77060e98eb0b7a9c4b3::PLANT {
    struct PLANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANT>(arg0, 6, b"PLANT", b"PLANT", b"Plants and crypto may seem like two vastly different topics, but they both represent innovation and growth in their own domains. Plants symbolize natural ecosystems, sustainability, and the foundation of life, while cryptocurrency embodies cutting-edge technology, decentralized finance, and the future of digital economies. Interestingly, these fields intersect in areas like blockchain-based carbon credit trading or tokenized investments in sustainable agriculture, highlighting how technology can support environmental stewardship and foster a greener, more inclusive financial future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qme8Wn2yEZEsBDTSA2aAomauiPkJby6wFGrsgD4SYkEEGG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

