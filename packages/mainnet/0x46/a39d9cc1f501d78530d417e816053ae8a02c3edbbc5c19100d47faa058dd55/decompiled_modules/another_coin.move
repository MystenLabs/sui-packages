module 0x46a39d9cc1f501d78530d417e816053ae8a02c3edbbc5c19100d47faa058dd55::another_coin {
    struct ANOTHER_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANOTHER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANOTHER_COIN>(arg0, 9, b"another", b"another coin", b"another another", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/952d8b32-e7dc-483f-adb0-f874376aac50.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANOTHER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANOTHER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

