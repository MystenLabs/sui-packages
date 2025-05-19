module 0xed076be57374cbc37cd0f211d679c6fa37324691cafc89fb58263d666a76b168::IKACHAN {
    struct IKACHAN has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<IKACHAN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x1b2b16f34c4104689a1be0090847a0893b38f22974eeecdef67933bbf41e1045 || 0x2::tx_context::sender(arg2) == @0x1b2b16f34c4104689a1be0090847a0893b38f22974eeecdef67933bbf41e1045, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKACHAN>>(arg0, arg1);
    }

    fun init(arg0: IKACHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKACHAN>(arg0, 9, b"IKACHAN", b"IkaChan", b"Ikachan loves you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafkreiga76mzecuuhvxkzuo4b7m5frob7dpj3bjcwtqu2ryqewyz2qqy5y")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<IKACHAN>>(0x2::coin::mint<IKACHAN>(&mut v2, 1000000000000000000, arg1), @0x1b2b16f34c4104689a1be0090847a0893b38f22974eeecdef67933bbf41e1045);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IKACHAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKACHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

