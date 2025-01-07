module 0x31bef4b9f852cb6e8923c760bab98f33f95343ed776d6c9b23ae73bc0e809e95::frogie {
    struct FROGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGIE>(arg0, 6, b"FROGIE", b"SUI FROGIE", b"The OG Sui Frog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifwog1_65a1d078d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

