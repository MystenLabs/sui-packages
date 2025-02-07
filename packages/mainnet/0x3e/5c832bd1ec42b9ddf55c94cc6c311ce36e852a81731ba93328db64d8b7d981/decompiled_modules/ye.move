module 0x3e5c832bd1ec42b9ddf55c94cc6c311ce36e852a81731ba93328db64d8b7d981::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YE>(arg0, 6, b"YE", b"KANYE", b"Kanye West Community On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738935995616.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

