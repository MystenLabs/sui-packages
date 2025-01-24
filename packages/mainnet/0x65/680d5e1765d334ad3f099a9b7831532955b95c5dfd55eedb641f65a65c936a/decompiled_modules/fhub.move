module 0x65680d5e1765d334ad3f099a9b7831532955b95c5dfd55eedb641f65a65c936a::fhub {
    struct FHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHUB>(arg0, 6, b"FHUB", b"F*UCKING HUB", b"We are sick and tired of this BS ruggers!! This is created only to those who want to make a token bond. Don't buy if you can't hold, and if you buy, you have to F*CKING HUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FHUB_8d369742eb.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

