module 0xbce4e7a904055659637d8f4c635b68ad7d634874c6041ed3ed0544ebc38f2a68::suir {
    struct SUIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIR>(arg0, 6, b"SUIr", b"SUIshi ROLL", b"Welcome to the land of SUIshi ROLL :) It will be great fun and also a cool long-term project!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiejjspmryfqm4htamog4cpme7x2th2us53n5lcy5jz5vhbyymsmaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

