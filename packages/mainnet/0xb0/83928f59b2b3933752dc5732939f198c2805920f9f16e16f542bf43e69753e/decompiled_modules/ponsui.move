module 0xb083928f59b2b3933752dc5732939f198c2805920f9f16e16f542bf43e69753e::ponsui {
    struct PONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONSUI>(arg0, 6, b"PONSUI", b"PonSUI", b"Hello almost-rich people! PonSUI is a community-memecoin on SuiNetwork that blends humor, the desire for wealth, and the blockchain world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732096234488.18")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

