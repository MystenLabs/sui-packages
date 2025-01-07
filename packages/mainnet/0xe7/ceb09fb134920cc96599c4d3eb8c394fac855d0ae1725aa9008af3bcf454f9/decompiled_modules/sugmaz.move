module 0xe7ceb09fb134920cc96599c4d3eb8c394fac855d0ae1725aa9008af3bcf454f9::sugmaz {
    struct SUGMAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGMAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGMAZ>(arg0, 6, b"SUGMAZ", b"Sugmaz on Sui", b"$SUGMAZ - The only sack worth holding. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048567_3ded177356.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGMAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGMAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

