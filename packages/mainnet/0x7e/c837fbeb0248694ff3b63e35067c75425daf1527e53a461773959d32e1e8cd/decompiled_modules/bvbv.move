module 0x7ec837fbeb0248694ff3b63e35067c75425daf1527e53a461773959d32e1e8cd::bvbv {
    struct BVBV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVBV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVBV>(arg0, 9, b"BVBV", b"SASD", b"TRYTRH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c0a6d24-c97b-4c9b-9c95-9a591d41a84a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVBV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVBV>>(v1);
    }

    // decompiled from Move bytecode v6
}

