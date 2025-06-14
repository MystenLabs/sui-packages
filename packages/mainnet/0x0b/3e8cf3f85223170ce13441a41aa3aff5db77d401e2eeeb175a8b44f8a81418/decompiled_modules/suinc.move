module 0xb3e8cf3f85223170ce13441a41aa3aff5db77d401e2eeeb175a8b44f8a81418::suinc {
    struct SUINC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINC>(arg0, 6, b"SUINC", b"Suinic", b"Suinic and the junction of Sonic and the Sui network just as the Sui network is growing SUINIC EXPLODES AS THE BIGGEST MEME ON THE NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyt5zuookn62g4ttzqy5j6odl6mfh4a5lnex6w7cihklkzcawkfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

