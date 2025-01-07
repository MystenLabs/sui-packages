module 0x546005361ad53d0ff84f504d4c991007698a7593280a08da4a4b00b2c61bcd92::sls {
    struct SLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLS>(arg0, 9, b"SLS", b"Salasar ", b"Devotional Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71f542f3-05d5-4117-b448-45db7f310741.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

