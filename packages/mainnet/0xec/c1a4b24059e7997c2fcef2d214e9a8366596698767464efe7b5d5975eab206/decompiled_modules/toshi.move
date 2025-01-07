module 0xecc1a4b24059e7997c2fcef2d214e9a8366596698767464efe7b5d5975eab206::toshi {
    struct TOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHI>(arg0, 6, b"TOSHI", b"SUITOSHI", b"Satoshi will come for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_N_D_N_D_4299a88ac9.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

