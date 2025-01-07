module 0x8ac67af283f22bfd7f34c0db85e23be2df27b998497a8e5aca6f892c140d9ec1::donne {
    struct DONNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONNE>(arg0, 6, b"DONNE", b"FORCE", b"BEST BETEU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TELEGRAM_BETEU_6b28ca1990.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

