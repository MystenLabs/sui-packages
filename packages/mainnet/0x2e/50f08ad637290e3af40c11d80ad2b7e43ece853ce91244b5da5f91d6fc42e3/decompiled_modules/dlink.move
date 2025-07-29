module 0x2e50f08ad637290e3af40c11d80ad2b7e43ece853ce91244b5da5f91d6fc42e3::dlink {
    struct DLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLINK>(arg0, 6, b"DLINK", b"Gently used Router DIR-320 D-Link Wireless", x"e4ba8ce6898be8b7afe794b1e599a8204449522d33323020442d4c696e6b20e697a0e7babfe8b7afe794b1e599a80a47656e746c79207573656420526f75746572204449522d33323020442d4c696e6b20576972656c6573730a0ae8bf99e5b086e99d9ee5b8b8e69c89e585b3e881940a546869732077696c6c206265207665727920636f6e6e6563746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreica4ydjofmfmi5hbsfbdbhkic2x3az34exq77wsv3f6sh4ib6dt7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DLINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

