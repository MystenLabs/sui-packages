module 0x76aeeb9ebddedabb95d44b81ae276fe9e105696f91113a67aa3171a99502fa4a::wwinc {
    struct WWINC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWINC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWINC>(arg0, 6, b"WWinc", b"World War 3", b"World War 3 is coming !!!!!!!!!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732038351304.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWINC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWINC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

