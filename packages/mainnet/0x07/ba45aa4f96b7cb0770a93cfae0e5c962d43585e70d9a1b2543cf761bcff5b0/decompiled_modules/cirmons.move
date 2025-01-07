module 0x7ba45aa4f96b7cb0770a93cfae0e5c962d43585e70d9a1b2543cf761bcff5b0::cirmons {
    struct CIRMONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRMONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRMONS>(arg0, 6, b"CIRMONS", b"CIRMONS SUI", b"$CIRMONS -  Adorable miniature monters !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_8_5d84ce7617.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRMONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIRMONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

