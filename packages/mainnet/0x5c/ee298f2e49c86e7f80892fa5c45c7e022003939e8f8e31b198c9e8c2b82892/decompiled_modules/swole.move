module 0x5cee298f2e49c86e7f80892fa5c45c7e022003939e8f8e31b198c9e8c2b82892::swole {
    struct SWOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOLE>(arg0, 6, b"SWOLE", b"SuiSwole Fox", b"He's just a swole fox on Sui. Men want to be him, women want to be with him. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736598959388.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

