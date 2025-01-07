module 0x154525e9d0e39330a3098705ff779450f06617e9664641bbed704ff13e986c74::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 9, b"WDOG", b"WetDog", b"There is a asimetrical wet mounth dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6498cebf-35f7-48c6-bfc8-671620d8eea1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

