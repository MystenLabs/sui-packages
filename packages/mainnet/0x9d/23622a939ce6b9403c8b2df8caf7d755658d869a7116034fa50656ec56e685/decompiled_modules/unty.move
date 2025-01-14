module 0x9d23622a939ce6b9403c8b2df8caf7d755658d869a7116034fa50656ec56e685::unty {
    struct UNTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNTY>(arg0, 9, b"UNTY", b"UNITY COIN", b"The Unity Coin serves as a powerful reminder of the importance of unity, peace, and cooperation in a world filled with conflict and division.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2431964a-45e2-410f-90c6-28f6fe6a5f27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

