module 0x3bf3d44645b6b94cfffe25db01532a604dcd39374be84364a5e17aba16a8944c::bublsui {
    struct BUBLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLSUI>(arg0, 6, b"BUBLSUI", b"BUBL", b"Bubbling on SuiNetwork to make frends. Only Official Bubl ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004364525.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBLSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

