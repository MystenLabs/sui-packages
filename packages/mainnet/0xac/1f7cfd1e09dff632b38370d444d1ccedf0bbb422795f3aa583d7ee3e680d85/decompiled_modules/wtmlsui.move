module 0xac1f7cfd1e09dff632b38370d444d1ccedf0bbb422795f3aa583d7ee3e680d85::wtmlsui {
    struct WTMLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTMLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTMLSUI>(arg0, 6, b"Wtmlsui", b"Watermelon", b"Suiiiiiiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001173439_00a26314a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTMLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTMLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

