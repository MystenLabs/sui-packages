module 0x89dd48e01c01720e3f22d7d6d77e551bf487281c7e54110a2ec65a218278899c::drain_coin {
    struct DRAIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAIN_COIN>(arg0, 6, b"USDS", b"Sui USD", b"Sui USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usdd-usdd-logo.png?v=035")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRAIN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRAIN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

