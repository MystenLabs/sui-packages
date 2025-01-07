module 0xf635791db15c7538ae321066dc40ed4f3c17889feee705529fc01140c7647d93::swapme {
    struct SWAPME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAPME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAPME>(arg0, 6, b"SWAPME", b"SUI SWAPME", b"Swap me for an estate, not for peanuts ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241022_224418_Chrome_8dc2478455.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAPME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAPME>>(v1);
    }

    // decompiled from Move bytecode v6
}

