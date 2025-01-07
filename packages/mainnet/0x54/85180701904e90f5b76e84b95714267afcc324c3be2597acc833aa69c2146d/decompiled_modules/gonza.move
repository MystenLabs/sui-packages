module 0x5485180701904e90f5b76e84b95714267afcc324c3be2597acc833aa69c2146d::gonza {
    struct GONZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONZA>(arg0, 8, b"Gonza", b"My friend gonza", b"gonzalo es un buen amigo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media-eze1-1.cdn.whatsapp.net/v/t61.24694-24/442720920_2169877933376740_8103260884608356917_n.jpg?ccb=11-4&oh=01_Q5AaII_FDwqrUQhUtd9d3sDlGDvU9EUbfrrJ9KHRE_4qhUsf&oe=66FF4941&_nc_sid=5e03e0&_nc_cat=101")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GONZA>(&mut v2, 77777777700000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONZA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

