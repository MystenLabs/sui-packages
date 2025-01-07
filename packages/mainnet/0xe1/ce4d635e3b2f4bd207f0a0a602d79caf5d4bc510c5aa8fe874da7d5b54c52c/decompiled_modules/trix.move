module 0xe1ce4d635e3b2f4bd207f0a0a602d79caf5d4bc510c5aa8fe874da7d5b54c52c::trix {
    struct TRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRIX>(arg0, 6, b"TRIX", b"Equitrix", b"Equitrix was conceived as a radical experiment by a secret collective of rogue scientists, economists, and hackers who saw the growing economic disparities and global oligarchy as an existential threat to humanity. The project, code-named Project Equinox, combined cutting-edge AI algorithms with human neural networks to create a being who could calculate and redistribute wealth in real time, targeting the financial elites who control the world's wealth and resources", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Equitrix_55d01a8bc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

