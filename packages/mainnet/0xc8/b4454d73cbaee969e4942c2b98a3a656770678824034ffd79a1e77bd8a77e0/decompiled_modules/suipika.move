module 0xc8b4454d73cbaee969e4942c2b98a3a656770678824034ffd79a1e77bd8a77e0::suipika {
    struct SUIPIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIKA>(arg0, 6, b"Suipika", b"Sui pikachu", b"Blue pikachu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731783772495.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

