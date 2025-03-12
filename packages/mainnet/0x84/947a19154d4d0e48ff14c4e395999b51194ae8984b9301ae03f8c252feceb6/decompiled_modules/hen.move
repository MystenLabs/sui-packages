module 0x84947a19154d4d0e48ff14c4e395999b51194ae8984b9301ae03f8c252feceb6::hen {
    struct HEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEN>(arg0, 9, b"HEN", b"henry", b"A token named henry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

