module 0xceb3cfc5ba0d946a48420c954cd0afe7cec91976aab9c95f0dc2f0e69f04dc52::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"World Liberty Financ", b"World Liberty Financial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970855876.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

