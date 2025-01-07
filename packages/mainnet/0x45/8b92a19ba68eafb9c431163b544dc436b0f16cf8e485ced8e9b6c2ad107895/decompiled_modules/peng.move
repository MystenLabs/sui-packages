module 0x458b92a19ba68eafb9c431163b544dc436b0f16cf8e485ced8e9b6c2ad107895::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"Sui Penguins", b"The greatest meme on Sui ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_crypto_penguins_a2c320cde0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

