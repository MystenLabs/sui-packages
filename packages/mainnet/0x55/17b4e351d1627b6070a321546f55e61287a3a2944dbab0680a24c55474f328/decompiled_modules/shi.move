module 0x5517b4e351d1627b6070a321546f55e61287a3a2944dbab0680a24c55474f328::shi {
    struct SHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHI>(arg0, 6, b"Shi", b"Sui Shi", b"The only shushi chef in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pikaso_reimagine_digital_painting_A_cute_cartoon_fish_wearing_a_che_1_37bf5f4e74.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

