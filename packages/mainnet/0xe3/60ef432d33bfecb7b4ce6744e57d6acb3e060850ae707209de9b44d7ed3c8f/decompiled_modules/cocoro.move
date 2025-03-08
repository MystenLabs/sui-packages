module 0xe360ef432d33bfecb7b4ce6744e57d6acb3e060850ae707209de9b44d7ed3c8f::cocoro {
    struct COCORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCORO>(arg0, 9, b"COCORO", b"COCORO SUI", b"New dog in family doge ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQujPFzvZ1Kt9tm6uGFsdqfA2RxL92EmQT9xojtkQsDyZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COCORO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCORO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

