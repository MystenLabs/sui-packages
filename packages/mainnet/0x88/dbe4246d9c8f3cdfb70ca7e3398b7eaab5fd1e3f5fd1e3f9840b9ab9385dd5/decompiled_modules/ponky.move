module 0x88dbe4246d9c8f3cdfb70ca7e3398b7eaab5fd1e3f5fd1e3f9840b9ab9385dd5::ponky {
    struct PONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKY>(arg0, 9, b"PONKY", b"PONKY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

