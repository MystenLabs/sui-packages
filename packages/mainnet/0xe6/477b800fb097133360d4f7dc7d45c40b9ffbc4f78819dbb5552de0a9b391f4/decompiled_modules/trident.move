module 0xe6477b800fb097133360d4f7dc7d45c40b9ffbc4f78819dbb5552de0a9b391f4::trident {
    struct TRIDENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIDENT>(arg0, 6, b"TRIDENT", b"TRIDENT OF SUI", b"$TRIDENT is a powerful token on Sui, symbolizing strength and control. Like the three heads of a trident, it strikes in different directions, giving holders the power to conquer markets with precision and force!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRIDENT_2edc186745.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIDENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIDENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

