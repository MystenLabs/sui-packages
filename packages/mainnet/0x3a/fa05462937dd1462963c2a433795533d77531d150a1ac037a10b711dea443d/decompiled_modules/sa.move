module 0x3afa05462937dd1462963c2a433795533d77531d150a1ac037a10b711dea443d::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 9, b"SA", b"HGJ", b"DF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f3ea7ac-4e6d-4df7-9779-477815b8ae62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA>>(v1);
    }

    // decompiled from Move bytecode v6
}

