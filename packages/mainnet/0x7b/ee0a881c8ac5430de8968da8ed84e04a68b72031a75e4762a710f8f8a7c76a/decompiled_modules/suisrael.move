module 0x7bee0a881c8ac5430de8968da8ed84e04a68b72031a75e4762a710f8f8a7c76a::suisrael {
    struct SUISRAEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISRAEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISRAEL>(arg0, 6, b"SUISRAEL", b"SUIISRAEL", b"This is memecoin that support Israil ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_circular_Memecoin_logo_with_a_vibrant_moder_1_6fe2082b17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISRAEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISRAEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

