module 0x5cacb1e686578d43df3857b00c42b4595ac2ed1ac4206a0321e6d225712e934f::suifun {
    struct SUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUN>(arg0, 6, b"SuiFun", b"SuiFun happy", x"496e205375692057652046756e2e0a4a7573742046756e2e0a4a7573742048617070792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731120723272.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

