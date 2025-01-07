module 0xb051f477d30cc1862b8169c8b4b316dd304890b7526371d778d274b0f342bee3::peee {
    struct PEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEE>(arg0, 9, b"peee", b"pep", b"ge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEEE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

