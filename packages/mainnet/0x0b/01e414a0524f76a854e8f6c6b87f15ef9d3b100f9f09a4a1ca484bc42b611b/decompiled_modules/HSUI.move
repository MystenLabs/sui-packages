module 0xb01e414a0524f76a854e8f6c6b87f15ef9d3b100f9f09a4a1ca484bc42b611b::HSUI {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 9, b"HSUI", b"Suicune", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/logo_light_noshade_ab181dc679.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HSUI>>(0x2::coin::mint<HSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HSUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

