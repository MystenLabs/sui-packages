module 0xcfb9fed8d100b8e16e0451140bd9ec75226d4b2b85cd01506125c9b7a606ae25::harleydog {
    struct HARLEYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARLEYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARLEYDOG>(arg0, 6, b"HARLEYDOG", b"Harley Dog", b"The token that stares into your soul (and your snacks). When you're eating, HARLEY sees. When you have food, HARLEY knows. Most powerful puppy eyes on chain fr fr no cap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732431103037.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARLEYDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARLEYDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

