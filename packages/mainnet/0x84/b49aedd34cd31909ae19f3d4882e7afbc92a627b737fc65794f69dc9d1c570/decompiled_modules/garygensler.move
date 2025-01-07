module 0x84b49aedd34cd31909ae19f3d4882e7afbc92a627b737fc65794f69dc9d1c570::garygensler {
    struct GARYGENSLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARYGENSLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARYGENSLER>(arg0, 6, b"GaryGensler", b"Lock Him Up", b"Lock Him Up! One man, chokepoint 2, against crypto. Bring him to justice. Profits will be spent on postcards to Gary's jail cell from the TG community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2dai_creation_1a65194dcf68397efb9e05b7cfd5116f_6814f59a55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARYGENSLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARYGENSLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

