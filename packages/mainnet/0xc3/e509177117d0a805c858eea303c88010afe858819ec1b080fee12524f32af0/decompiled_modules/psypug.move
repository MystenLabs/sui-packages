module 0xc3e509177117d0a805c858eea303c88010afe858819ec1b080fee12524f32af0::psypug {
    struct PSYPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSYPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYPUG>(arg0, 6, b"PSYPUG", b"Psycho Pug", b"Psycho Pug ($PSYPUG)  The most unhinged, high-energy meme token in crypto! Fueled by pure chaos and turbocharged degeneracy, $PSYPUG is here to dominate the meme space with its wild, over-the-top personality. Whether you're apeing in for the laughs or riding the hype to the moon, this pug ain't slowing down. Bark, zoom, send it!  #PSYPUG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLE_2025_02_1811_20_37_Ahilariousandchaoticpugwithwildbulgingeyesacrazedexpressionanditstonguehangingout_Thepugishyperactivesurroundedbyenergydri_ezgif_com_resize_f7948c5574.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSYPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

