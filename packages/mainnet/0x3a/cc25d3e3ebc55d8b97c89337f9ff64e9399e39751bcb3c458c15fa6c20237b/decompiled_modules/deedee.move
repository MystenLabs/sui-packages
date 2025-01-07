module 0x3acc25d3e3ebc55d8b97c89337f9ff64e9399e39751bcb3c458c15fa6c20237b::deedee {
    struct DEEDEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEDEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEDEE>(arg0, 6, b"DEEDEE", b"DogWofHoody", b"A meme coin of a meme coin.  Yes, my dog will sit on the toilet for hours. She will let her son show you her tits.  She will get into a cage and be into BDSM.  She will light herself on fire, just buy her. She is a dog wof hoody.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732450472209.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEDEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEDEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

