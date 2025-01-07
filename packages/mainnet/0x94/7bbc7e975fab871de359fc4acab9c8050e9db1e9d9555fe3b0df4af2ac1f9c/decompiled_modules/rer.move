module 0x947bbc7e975fab871de359fc4acab9c8050e9db1e9d9555fe3b0df4af2ac1f9c::rer {
    struct RER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RER>(arg0, 9, b"RER", b"WORKER", b"HARD WORKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b751cdaf-a2e9-4f64-8670-2297a763a398.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RER>>(v1);
    }

    // decompiled from Move bytecode v6
}

