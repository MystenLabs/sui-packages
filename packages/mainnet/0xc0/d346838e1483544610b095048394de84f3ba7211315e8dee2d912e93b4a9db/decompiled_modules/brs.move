module 0xc0d346838e1483544610b095048394de84f3ba7211315e8dee2d912e93b4a9db::brs {
    struct BRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRS>(arg0, 9, b"BRS", b"BARASH", b"Only hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/984f0e79-f2dd-4527-979a-5ff8af09a47f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

