module 0x88350b1d10e8483b6424e97034a3eae3422dfddd67c8c8fbaf22f795f123e460::el_chapo {
    struct EL_CHAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EL_CHAPO, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 752 || 0x2::tx_context::epoch(arg1) == 753, 1);
        let (v0, v1) = 0x2::coin::create_currency<EL_CHAPO>(arg0, 9, b"chapo", b"el chapo", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EL_CHAPO>(&mut v2, 1000000000000000000, @0xe89afcbdaf461ff51af1f416183df2316446c1777dfa2ef2e7f97b702266ecbf, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EL_CHAPO>>(v2, @0xe89afcbdaf461ff51af1f416183df2316446c1777dfa2ef2e7f97b702266ecbf);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EL_CHAPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

