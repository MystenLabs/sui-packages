module 0xd6fe0288800441b4d25b7bb377749d27dc115cb8c985a99b49cc3769cbbcd29b::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 9, b"PINKY", b"Pinky the Pineapple", x"50696e6b79207468652050696e656170706c652e20546865206e6577206d656d6520636f696e2073656e736174696f6e20796f7520646f6e27742077616e7420746f206661646520f09f8d8df09f9883", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BkvnWerVaa6NYvPAdeX5kBsGhCRjDnUUutAa5KbUvJwJ.png?size=xl&key=664e3b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINKY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

