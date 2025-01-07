module 0x5a562a622cf656b6f6868a8ee8594a67446409be4e5276861c444d8418d14b7c::kama {
    struct KAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMA>(arg0, 6, b"KAMA", b"CHIIKAWA", b"Chiikawa () is the titular character and protagonist of the viral manga and anime series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728712003534_fba7e0f76d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

