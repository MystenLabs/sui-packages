module 0x15b8cb7c389c5bcacbadfc4a7fd80b0a6d8e25c13c2c575870c066ccd2ee13ad::suibiao {
    struct SUIBIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIAO>(arg0, 9, b"SUIBIAO", b"Sui Biao", x"53756920244249414f202d207468652066756e69657374206d656d6520696e20746865206561737420f09f90bc2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafkreihubxtzyyspq7gb5virs4godvyebla4dijrtkkqzqems7pkgtwfju"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBIAO>>(v1);
        0x2::coin::mint_and_transfer<SUIBIAO>(&mut v2, 1000000000000000000, @0x31e05b4348c3510f13f33ecf4fca09345eec7658f904f65362c7b9f08c62f603, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIBIAO>>(v2);
    }

    // decompiled from Move bytecode v6
}

