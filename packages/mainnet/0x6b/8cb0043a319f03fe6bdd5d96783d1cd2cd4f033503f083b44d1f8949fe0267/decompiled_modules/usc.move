module 0x6b8cb0043a319f03fe6bdd5d96783d1cd2cd4f033503f083b44d1f8949fe0267::usc {
    struct USC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USC>(arg0, 6, b"USC", b"Useless Sui Coin", b"This coin is the most useless coin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieg6sdpp7ai3rv4hte4s6mdl25euvu2ffwsjvmwvy6frzq5mfjiqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

