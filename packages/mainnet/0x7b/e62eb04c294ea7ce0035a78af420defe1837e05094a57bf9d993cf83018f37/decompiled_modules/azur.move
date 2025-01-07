module 0x7be62eb04c294ea7ce0035a78af420defe1837e05094a57bf9d993cf83018f37::azur {
    struct AZUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUR>(arg0, 6, b"Azur", b"**AzurCryptus**", b"\"Azur\" refers to the color blue, derived from the word \"azure,\" which describes a bright or deep blue, often associated with the sky or the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735442869975.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

