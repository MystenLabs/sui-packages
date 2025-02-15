module 0x16d27c54867919e1d0e007de663a3c148288dc1e062b9b5af494996ec72bb2e6::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCCOLI>(arg0, 9, b"BROCCOLI", b"BROCCOLI ", b"BROCCOLI CZ DOG ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/376d2660-c454-4812-a811-b2b798133537.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCCOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

