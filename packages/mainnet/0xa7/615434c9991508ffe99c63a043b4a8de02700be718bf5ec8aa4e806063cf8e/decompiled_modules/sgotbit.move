module 0xa7615434c9991508ffe99c63a043b4a8de02700be718bf5ec8aa4e806063cf8e::sgotbit {
    struct SGOTBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOTBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOTBIT>(arg0, 9, b"sgotbit", b"Sui Gotbit", b"Sui hedge fund Gotbit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.rootdata.com/images/b6/1682049677314.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SGOTBIT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOTBIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOTBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

