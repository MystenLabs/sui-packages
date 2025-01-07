module 0x5ebb698d4eaafcda61fac51e33bbbe1d6c9051555fba16d85fa947adfc06f407::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 9, b"AIDOGE", b"AI Doge", b"AI Doge on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmXuLkCRQ4VtKFjsPBAbL4emKa6xW2k56cS78KdKGLLPXp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
        0x2::coin::mint_and_transfer<AIDOGE>(&mut v2, 1000000000000000000, @0x7dfb10207059a61094d0b39267bac3544b960e4e1346805e16f012350ede61a4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIDOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

