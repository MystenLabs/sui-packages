module 0x8fccd21e51a41f506820db81393a3f9cf83c921d520e3524816e28756b870ee7::cit {
    struct CIT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CIT>>(0x2::coin::mint<CIT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIT>(arg0, 6, b"CIT", b"CIT Token", b"CIT is the native token of Crypto Invest Terminal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://6mlzu7yihlt2drajl5idor3p5nyt7kwtgmnmudptt4tx7ff7fzkq.arweave.net/8xeafwg656HECV9QN0dv63E_qtMzGsoN858nf5S_LlU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

