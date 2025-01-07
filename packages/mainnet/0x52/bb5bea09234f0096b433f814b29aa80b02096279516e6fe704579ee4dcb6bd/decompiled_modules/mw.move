module 0x52bb5bea09234f0096b433f814b29aa80b02096279516e6fe704579ee4dcb6bd::mw {
    struct MW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MW>(arg0, 9, b"MW", b"Mewww", b"Test test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17e7b53b-51cf-497b-b252-9555785d0e96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MW>>(v1);
    }

    // decompiled from Move bytecode v6
}

