module 0xadd7afb10e783b05b9bd65ccd7581bf4972efec31269eb727eba9d89113a2da5::hawks {
    struct HAWKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWKS>(arg0, 6, b"HawkS", b"Hawksui", b"Everyone lost their capital on #hawk in sol. This will be an easy opportunity to gain all that shait back! So Hawk Tuah girl spit on this shait, make it shiny and lets sell the crap out of it. Let the money printing machine begin. BTW You're welcome.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733419583537.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAWKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

