module 0x494938edb1d32d76177b3b47ad0ccdc41fef86e394ae98efc70ff407a06f4db8::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 6, b"Dogs", b"Dogs on SUI", x"4d656d6520696e73706972656420627920435a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_14_10_39_241925463e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

