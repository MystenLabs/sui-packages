module 0xbeb0f2b6d33dc69af9c23ff4d36717ab864cd1e40b939022e848c59271c0ebbf::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGS>(arg0, 6, b"DOGS", b"FIRST SUI DOGS", b"First Dogs on Sui : https://www.suidogscoin.xyz | https://t.me/SuiDogs_Channel | https://t.me/SuiDogs_Channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/about_illustration_0678b61145.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

