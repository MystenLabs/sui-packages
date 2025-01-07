module 0x4267d19ac73c09f5707f332227fde797770ccd5f07c35123bf8312c3ef821f24::dfp {
    struct DFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFP>(arg0, 9, b"DFP", b"DOG WIF PANTS", b"a dog with pants (jeans) on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DFP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFP>>(v1);
    }

    // decompiled from Move bytecode v6
}

