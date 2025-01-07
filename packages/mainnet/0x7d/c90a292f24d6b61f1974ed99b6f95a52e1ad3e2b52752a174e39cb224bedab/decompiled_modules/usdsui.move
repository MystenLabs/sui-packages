module 0x7dc90a292f24d6b61f1974ed99b6f95a52e1ad3e2b52752a174e39cb224bedab::usdsui {
    struct USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDSUI>(arg0, 6, b"USDSUI", b"the USDSUI", b"USDSUI THE SUI STABLECOIN MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/USDSUI_398958a038.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

