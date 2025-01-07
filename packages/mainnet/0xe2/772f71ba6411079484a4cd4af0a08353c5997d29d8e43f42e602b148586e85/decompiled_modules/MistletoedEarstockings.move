module 0xe2772f71ba6411079484a4cd4af0a08353c5997d29d8e43f42e602b148586e85::MistletoedEarstockings {
    struct MISTLETOEDEARSTOCKINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTLETOEDEARSTOCKINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTLETOEDEARSTOCKINGS>(arg0, 0, b"COS", b"Mistletoe'd Earstockings", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Mistletoe'd_Earstockings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISTLETOEDEARSTOCKINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTLETOEDEARSTOCKINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

