module 0xf24e0b7b74d2140ab130f2f4349ba1d08c1ab002a8079e66c8eb79a2d12d1bb9::dckt {
    struct DCKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKT>(arg0, 6, b"DCKT", b"Ducketeers", b"Join the flock! #Ducketeers #Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_e3d4e8a791.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

