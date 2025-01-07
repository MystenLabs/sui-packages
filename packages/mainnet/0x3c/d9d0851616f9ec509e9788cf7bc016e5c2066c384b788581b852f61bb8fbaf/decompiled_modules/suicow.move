module 0x3cd9d0851616f9ec509e9788cf7bc016e5c2066c384b788581b852f61bb8fbaf::suicow {
    struct SUICOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOW>(arg0, 6, b"SuiCow", b"Sui Cow", b"We are bullish on the future of the Sui network. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_23_20_38_53_5048c1d094.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

