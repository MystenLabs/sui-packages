module 0x3eada6beb82af2bb6b1d0c79d376ff3573a0e4bd54639141ef4246e2173e9642::suidoggy {
    struct SUIDOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGGY>(arg0, 9, b"SUIDOGGY", b"SUIDOGGY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOGGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

