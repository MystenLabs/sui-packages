module 0xfeea1fdcace57fa35ba2e0d526147066b6f594ea1bbcf5b468eeb18bb1c71e51::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAI>(arg0, 6, b"NAI", b"Neuro AI Agent", b"Building smarter AI with neuromorphic computing and advanced training algorithms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicw72bsgx6gcffyaynquy4weilqgfl4bl3xvijhwemyqmxw45og7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

