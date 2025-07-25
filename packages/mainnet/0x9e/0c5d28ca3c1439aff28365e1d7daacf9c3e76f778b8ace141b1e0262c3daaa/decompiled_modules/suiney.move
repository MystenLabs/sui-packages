module 0x9e0c5d28ca3c1439aff28365e1d7daacf9c3e76f778b8ace141b1e0262c3daaa::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 6, b"SUINEY", b"Sydney SUIney", b"Ecosystem Intern", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753463628437.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

