module 0xfd63b2b09e7c38c62d7d8a940cd675db007571b503df4c9f9457512e85f271ab::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRD>(arg0, 6, b"BIRD", b"Suibird", x"54686520626f6c646573742062697264206f6e205375692e202442495244206973206d656d65732c20636f6d6d756e6974792c20616e64206d6f6f6e20647265616d7320696e206f6e652e204a6f696e2074686520666c6f636b2c20616e64206c6574e28099732074616b6520666c696768742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755176822650.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

