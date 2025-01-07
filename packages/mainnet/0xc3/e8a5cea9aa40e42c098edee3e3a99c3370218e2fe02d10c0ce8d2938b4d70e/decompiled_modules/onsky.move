module 0xc3e8a5cea9aa40e42c098edee3e3a99c3370218e2fe02d10c0ce8d2938b4d70e::onsky {
    struct ONSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONSKY>(arg0, 9, b"ONSKY", b"MOON", b"Its moon coin will top in sky ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9af42625-2a3a-401d-bbe7-392810fe5ada.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

