module 0x798546dbb816c471fe6605d280820db13051ae177e3595224d3999f34f408829::suinicorn {
    struct SUINICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINICORN>(arg0, 6, b"SUINICORN", b"Suinicorn", b"Ride the wave with the Suinicorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_A_cran_2024_10_07_000822_083ca6a36b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

