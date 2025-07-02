module 0x8b9b023e498fed3e9e27b8451b685ce00130ab06a17948cd2384778beb1604d1::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 6, b"PAN", b"PANDA", b"Baby Panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicthuhd4ndidzx4evgxfzzb3pohezj5vtylxkznvsbuthgej4ckeu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

