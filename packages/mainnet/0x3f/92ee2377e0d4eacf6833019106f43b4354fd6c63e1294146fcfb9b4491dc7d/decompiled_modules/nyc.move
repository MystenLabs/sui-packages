module 0x3f92ee2377e0d4eacf6833019106f43b4354fd6c63e1294146fcfb9b4491dc7d::nyc {
    struct NYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYC>(arg0, 9, b"NYC", b"NewYear", x"4c6574e28099732063656c65627261746520746865206e6577207965617220696e206772616e64207374796c65207769746820746865204e4557205945415220434f494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a30787d5-3e9e-434c-934e-c8bddac34a98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

