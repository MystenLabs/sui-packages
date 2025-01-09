module 0x2359629247abf1320765729cad694f1ace11b202382b22da2e3b64ed8684c832::wfish {
    struct WFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFISH>(arg0, 6, b"WFISH", b"Wizard Fish", x"0a2257697a6172642046697368205370656c6c7320596f75722057616c6c65742122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736443764288.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

