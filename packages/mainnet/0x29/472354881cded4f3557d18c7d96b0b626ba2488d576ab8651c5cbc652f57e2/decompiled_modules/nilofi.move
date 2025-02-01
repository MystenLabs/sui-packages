module 0x29472354881cded4f3557d18c7d96b0b626ba2488d576ab8651c5cbc652f57e2::nilofi {
    struct NILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILOFI>(arg0, 6, b"Nilofi", b"NILOFI ON SUI", b"Born in the cold, raised by the night, pockets full of ice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250202_023027_225_264869f032.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

