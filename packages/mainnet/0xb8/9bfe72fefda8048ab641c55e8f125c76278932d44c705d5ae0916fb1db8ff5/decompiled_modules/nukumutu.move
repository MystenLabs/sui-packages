module 0xb89bfe72fefda8048ab641c55e8f125c76278932d44c705d5ae0916fb1db8ff5::nukumutu {
    struct NUKUMUTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKUMUTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKUMUTU>(arg0, 6, b"Nukumutu", b"Satushi Nukumutu", b"we lyk to make buttcoin and stack sum sats. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_23_20_02_838ddeb951.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKUMUTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUKUMUTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

