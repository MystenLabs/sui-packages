module 0x7e4ab8c6422262040fe39d1255d0a52ef4b2bb7abdb946267c60be5084ba67db::wylly {
    struct WYLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYLLY>(arg0, 6, b"Wylly", b"Willy the Billi", b"Willy the Billionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagen_2024_09_17_211617373_ef106b7838.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

