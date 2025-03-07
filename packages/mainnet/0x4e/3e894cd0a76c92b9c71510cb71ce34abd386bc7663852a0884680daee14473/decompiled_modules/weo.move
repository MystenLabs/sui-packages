module 0x4e3e894cd0a76c92b9c71510cb71ce34abd386bc7663852a0884680daee14473::weo {
    struct WEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEO>(arg0, 9, b"WEO", b"Weewoo", b"Weewooweewoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f86ad578-188f-49e9-9630-c8f81de5a2d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

