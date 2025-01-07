module 0x93ff992c85ecf104481a21e147faec15bb079e4802b7af6967e736ae90983ca4::suibnb {
    struct SUIBNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBNB>(arg0, 9, b"SUIBNB", b"SUIBNB", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBNB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBNB>>(v2, @0xe0ab976b01ab2bff1d4c8a97e6c9b4a6ab9392d45b835a3c7c25572cd5e6e860);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

