module 0x8bd5cdac8e29ac14d7e2ebeeecc3465c1d8a39eae6df686b22b6141ba76ded63::crocosui {
    struct CROCOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCOSUI>(arg0, 9, b"CROCOSUI", b"Croco Sui", b"Croco is the first croc on Sui. Join the Croco Cult & Chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fnewpfp2_a6ad5c1103.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CROCOSUI>(&mut v2, 500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCOSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

