module 0x3db5e9565b8b1f0eb408d05e065b1b01ad6086c9653f605b5ee06b11a74d6104::put {
    struct PUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUT>(arg0, 6, b"PUT", b"PUNK IN A TAPE", b"A Punk in Duct Tape is a playful conceptual artwork blending the iconic CryptoPunk pixelated character style with the absurdity of the famous \"banana taped to a wall\" art. It features a pixelated CryptoPunk figure adhered to a wall using a strip of duct tape, symbolizing the intersection of meme culture, digital art, and crypto innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_26_15_54_36_A_highly_pixelated_conceptual_digital_artwork_of_a_crypto_punk_character_adhered_to_a_wall_with_duct_tape_The_crypto_punk_has_an_extreme_8_bit_style_138a1ec5ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

