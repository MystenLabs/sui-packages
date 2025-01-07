module 0x62cea86f3a9bd8055c462d57fa1686b68844326c38ff1310d7f1a87de1eab930::suiurf {
    struct SUIURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIURF>(arg0, 6, b"SUIURF", b"Suiurf", b"The Suiurf is blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GONR_6877_cc18025e87.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

