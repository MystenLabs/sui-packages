module 0x3bac1aa81c0f209c6182ec32ef2bfaedc025ffdf573dd4ccf0b5e8e27cb822a::pepemcdo {
    struct PEPEMCDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMCDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMCDO>(arg0, 9, b"PEPEMCDO", b"PEPEMCDO", b"off token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPEMCDO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMCDO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMCDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

