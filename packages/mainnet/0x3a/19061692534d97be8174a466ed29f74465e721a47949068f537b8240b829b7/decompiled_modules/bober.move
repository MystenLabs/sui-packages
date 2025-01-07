module 0x3a19061692534d97be8174a466ed29f74465e721a47949068f537b8240b829b7::bober {
    struct BOBER has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOBER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOBER>>(0x2::coin::mint<BOBER>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: BOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBER>(arg0, 9, b"BOBER", b"Bober The Beaver", x"426f6265722074686520426561766572206f6e2053554920697320612068617264776f726b696e6720616e642068696c6172696f7573206d6173636f7420666f7220626c6f636b636861696e20656e7468757369617374732120f09fa6abf09f92bb204b6e6f776e20666f72206275696c64696e6720696e747269636174652064616d7320616e64206e6f772c20646563656e7472616c697a656420647265616d732c20426f626572206272696e677320616e20696e6475737472696f75732079657420706c617966756c2073706972697420746f207468652053554920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmfVNThvAkGxoMsb1hdj4VMvf5RNqCDPUYPjWL1wg3eV5F?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

