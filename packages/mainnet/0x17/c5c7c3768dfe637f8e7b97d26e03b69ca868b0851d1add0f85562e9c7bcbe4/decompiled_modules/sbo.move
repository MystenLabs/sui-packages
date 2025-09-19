module 0x17c5c7c3768dfe637f8e7b97d26e03b69ca868b0851d1add0f85562e9c7bcbe4::sbo {
    struct SBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBO>(arg0, 6, b"SBO", b"Suiboom", b"SuiBoom is the hottest new meme coin on the SUI blockchain, ready to explode with explosive gains! Inspired by the thrill of a rocket launch, this vibrant token is set to take the crypto world by storm. Join the boom and ride the wave to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012776_394e945350.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

