module 0x8ad8c9abb44128e437891ced9d33f2dfc8ebdb84327925c484399947431a20c9::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDOG", b"BUNNYDOG", b"$BDOG, Sui's best dog! Always hungry for hotdogs. More than just a coin, it's the dawg of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001405277.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

