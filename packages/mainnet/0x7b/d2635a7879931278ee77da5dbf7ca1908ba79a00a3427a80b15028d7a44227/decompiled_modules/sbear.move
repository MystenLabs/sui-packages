module 0x7bd2635a7879931278ee77da5dbf7ca1908ba79a00a3427a80b15028d7a44227::sbear {
    struct SBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEAR>(arg0, 6, b"SBEAR", b"POLAR SUI BEAR", b"the coldest bear in the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_e_I_cran_2024_10_01_a_I_08_15_9d5d5b252e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

