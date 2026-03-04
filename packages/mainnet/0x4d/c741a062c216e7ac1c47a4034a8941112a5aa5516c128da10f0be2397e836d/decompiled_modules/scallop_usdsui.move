module 0x4dc741a062c216e7ac1c47a4034a8941112a5aa5516c128da10f0be2397e836d::scallop_usdsui {
    struct SCALLOP_USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_USDSUI>(arg0, 6, b"sUSDSUI", b"sUSDSUI", b"Scallop interest-bearing token for USDSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://xmalnrwtxuhoijrcua3gf3y22fa3r5fjyvvrqjxyp4udip2uew7a.turbo-gateway.com/uwC2xtO9DuQmIqA2Yu8a0UG49KnFaxgm-H8oND9UJb4?")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_USDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_USDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

