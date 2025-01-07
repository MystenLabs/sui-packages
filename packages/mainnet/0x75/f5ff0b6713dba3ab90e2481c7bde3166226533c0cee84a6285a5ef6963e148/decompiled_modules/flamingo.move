module 0x75f5ff0b6713dba3ab90e2481c7bde3166226533c0cee84a6285a5ef6963e148::flamingo {
    struct FLAMINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMINGO>(arg0, 6, b"Flamingo", b"Flamingo 2", b"Flamingo CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_Png_928x1024_021c83dcee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAMINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

