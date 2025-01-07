module 0xff7ef0c73603860bf1ecc9e87ae2977f7617ec9f9517829a511e0383be1f6c41::siozm {
    struct SIOZM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIOZM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIOZM>(arg0, 6, b"SIOZM", b"Sionizm", b"Promised Land :Theodor Herzl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1912_ca1ead2a46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIOZM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIOZM>>(v1);
    }

    // decompiled from Move bytecode v6
}

