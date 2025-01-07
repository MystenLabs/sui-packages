module 0x5a2687a7bd43550f67482bb2063af987555450079f55ce15abfa5753767dc5ca::xducks {
    struct XDUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDUCKS>(arg0, 6, b"XDUCKS", b"XDUCK ON SUI", b"Welcome to $XDUCKS (Dumb XDUCKS) ! The most memeable memecoin in existence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_42_46_aba8e271eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XDUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

