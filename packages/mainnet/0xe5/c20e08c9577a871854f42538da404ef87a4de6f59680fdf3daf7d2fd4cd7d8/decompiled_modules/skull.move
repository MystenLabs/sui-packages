module 0xe5c20e08c9577a871854f42538da404ef87a4de6f59680fdf3daf7d2fd4cd7d8::skull {
    struct SKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKULL>(arg0, 6, b"SKULL", b"WOLF SKULL", b"Wolfskull, a menacing creation by Matt Furie in his book Mindviscosity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_07_20_45_40_f116826efe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

