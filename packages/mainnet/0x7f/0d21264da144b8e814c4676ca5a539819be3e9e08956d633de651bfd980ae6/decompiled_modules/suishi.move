module 0x7f0d21264da144b8e814c4676ca5a539819be3e9e08956d633de651bfd980ae6::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"Suishi", b"Suishi CAT", b"Suishi with a twist of purrfection, combining the cuteness of cats and the art of sushi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954556697.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

