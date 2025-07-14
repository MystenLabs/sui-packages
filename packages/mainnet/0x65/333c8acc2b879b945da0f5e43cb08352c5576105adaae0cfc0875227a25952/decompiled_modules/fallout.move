module 0x65333c8acc2b879b945da0f5e43cb08352c5576105adaae0cfc0875227a25952::fallout {
    struct FALLOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALLOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALLOUT>(arg0, 6, b"FALLOUT", b"Fallout On Sui", b"Vault up! Cash out!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxood5k2sxbekpy2knavbr7aa4jpp57ls37guznak5aga4725axm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALLOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FALLOUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

