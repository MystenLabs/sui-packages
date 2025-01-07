module 0xc10bdb462f5b5379b5207d2fff8028e755c7d0eea24527c29ddff5cf17a58b26::aitrump {
    struct AITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AITRUMP>(arg0, 9, b"AITRUMP", b"AI TRUMP", b"AI TRUMP MAKE CRYPTO GREAT AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4276696-65ed-4949-8d1e-db64a20cfe32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

