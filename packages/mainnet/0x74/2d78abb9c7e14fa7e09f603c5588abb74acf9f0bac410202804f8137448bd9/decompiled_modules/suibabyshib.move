module 0x742d78abb9c7e14fa7e09f603c5588abb74acf9f0bac410202804f8137448bd9::suibabyshib {
    struct SUIBABYSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABYSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABYSHIB>(arg0, 9, b"SSHIB", b"Sui BabyShib", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBABYSHIB>(&mut v2, 100000000000000000, @0x27faf295fb0afa112f5b1e875abecbbbc0776a17e709e716529dd4917cd7c110, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBABYSHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABYSHIB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

