module 0x34cd068d7a91510ee24405b01edf4c40f845b4a9edd2f7af078481e9eeb5e99b::dlink {
    struct DLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLINK>(arg0, 6, b"DLINK", b"D-LINK", x"e4ba8ce6898be8b7afe794b1e599a8204449522d33323020442d4c696e6b20e697a0e7babfe8b7afe794b1e599a80a47656e746c79207573656420526f75746572204449522d33323020442d4c696e6b20576972656c657373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreica4ydjofmfmi5hbsfbdbhkic2x3az34exq77wsv3f6sh4ib6dt7u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DLINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

