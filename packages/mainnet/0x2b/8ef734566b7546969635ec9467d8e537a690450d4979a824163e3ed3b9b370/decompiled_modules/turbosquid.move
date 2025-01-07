module 0x2b8ef734566b7546969635ec9467d8e537a690450d4979a824163e3ed3b9b370::turbosquid {
    struct TURBOSQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSQUID>(arg0, 6, b"TurboSquid", b"Turbo Squid", x"466972737420547572626f5371756964206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731065646513.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSQUID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSQUID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

