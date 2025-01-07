module 0x9a4b1977656b5558e3c76ee38b5ae01cc1d235a3b12e7cd2e1b10f48ca3d91c8::suigl {
    struct SUIGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGL>(arg0, 6, b"SUIGL", b"Suigull", b"Suigull on Sui. Swoop and grab that fish!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo22_6e95628431.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

