module 0xe4efc4d9421eaf7756b13befbe3705012754a3a7889841fc3d8d082da89c7522::scart {
    struct SCART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCART>(arg0, 6, b"Scart", b"SUISCRAT", b"hi, Im $SCRAT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9j_Cb21_Pn_400x400_206198e7d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCART>>(v1);
    }

    // decompiled from Move bytecode v6
}

