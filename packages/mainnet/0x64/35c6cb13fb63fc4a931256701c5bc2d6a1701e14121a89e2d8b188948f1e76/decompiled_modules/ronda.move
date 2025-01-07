module 0x6435c6cb13fb63fc4a931256701c5bc2d6a1701e14121a89e2d8b188948f1e76::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"Ronda", b"Ronda On Sui", b"Ronda On Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_D9_C2_D8_D_ADC_8_4_C68_B961_EA_385_DE_57289_58646f8093_ezgif_com_webp_to_jpg_converter_transformed_0334779fc2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

