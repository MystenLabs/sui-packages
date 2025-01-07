module 0x3ec632f793573978a3580d641a3eb11802bc99e12f429e50e758e1110424f0a9::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"CHEEMS", b"Cheems On Sui", x"436865656d7320697320746865206c6f7264206f66206d656d652c20610a736d616c6c2c207069746966756c2c2068656c706c65737320536869626120496e75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731445473634.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

