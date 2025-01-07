module 0x863d4b578f7ffb0f483d55a82b6ae121a99929162ff522d049d493b3bb2144d::sfish {
    struct SFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISH>(arg0, 6, b"SFISH", b"sFish", b"Siiiick fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ln_L18_Vfb_400x400_0572a872f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

