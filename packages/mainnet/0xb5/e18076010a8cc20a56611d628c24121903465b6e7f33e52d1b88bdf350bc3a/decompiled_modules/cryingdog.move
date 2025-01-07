module 0xb5e18076010a8cc20a56611d628c24121903465b6e7f33e52d1b88bdf350bc3a::cryingdog {
    struct CRYINGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYINGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYINGDOG>(arg0, 6, b"Cryingdog", b"Cdog", x"4a7573742070757420612063757420646f672068657265200a4c696b652068696d206275742068696d0a4a7573742062757920697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2421_7cfe5544c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYINGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRYINGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

