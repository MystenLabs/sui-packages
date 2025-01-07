module 0x143ba6d23e913a8de9fe4068546e72baf03bfeed9d18f4a4f7da0d13ea8acbb4::ferg {
    struct FERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERG>(arg0, 6, b"Ferg", b"ferg on sui", b"a tiny frog in the wild world of sui $ferg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ferg_ced0356c9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

