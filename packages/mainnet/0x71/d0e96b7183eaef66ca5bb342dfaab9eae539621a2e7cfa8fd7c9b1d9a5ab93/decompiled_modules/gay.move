module 0x71d0e96b7183eaef66ca5bb342dfaab9eae539621a2e7cfa8fd7c9b1d9a5ab93::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 9, b"GAY", b"gay", b"gay test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/d/d1/TwoMenKiss.GayPrideParade.WDC.10June2017.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

