module 0xfd36404107989ae89f77e8b3f260069adf3047e04bdce04f45c7d109a74d8730::gish {
    struct GISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GISH>(arg0, 6, b"GISH", b"GISHERS", b"$GISH is the official currency of the Gisher Family in the Sui Land.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240926_WA_0009_0b59d72428.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

