module 0x5e544431c6b73859cdc0bde5133b35f2400698246428656b3b820928854f511b::Heat_Destroyer {
    struct HEAT_DESTROYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAT_DESTROYER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAT_DESTROYER>(arg0, 9, b"HEAT", b"Heat Destroyer", b"pulverising from the east. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1944791661126496263/6imJ6bnB_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAT_DESTROYER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAT_DESTROYER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

