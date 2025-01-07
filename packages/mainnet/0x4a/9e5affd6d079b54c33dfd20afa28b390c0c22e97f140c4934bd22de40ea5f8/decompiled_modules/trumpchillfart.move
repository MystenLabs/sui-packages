module 0x4a9e5affd6d079b54c33dfd20afa28b390c0c22e97f140c4934bd22de40ea5f8::trumpchillfart {
    struct TRUMPCHILLFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCHILLFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCHILLFART>(arg0, 9, b"TRUMPCHILLFART", b"TRUMPCHILLFART", b"make 1000x again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a57.foxnews.com/media2.foxnews.com/BrightCove/694940094001/2016/08/10/640/360/694940094001_5078448229001_4568f687-1a13-490d-9f95-14e04b5c802e.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPCHILLFART>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCHILLFART>>(v2, @0xf77deb5327ad4d5c260ddc86b579c8c5ad50a28e619cc1cd4cb26197eb7060ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPCHILLFART>>(v1);
    }

    // decompiled from Move bytecode v6
}

