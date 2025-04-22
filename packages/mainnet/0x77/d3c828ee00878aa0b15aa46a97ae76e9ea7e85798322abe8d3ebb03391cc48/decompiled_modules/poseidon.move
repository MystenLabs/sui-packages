module 0x77d3c828ee00878aa0b15aa46a97ae76e9ea7e85798322abe8d3ebb03391cc48::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"Poseidon", b"poseidon", x"225468657265277320616e206f6c6420736179696e67202d204966206120686f74206769726c20746578747320796f752061626f75742063727970746f2c20626c6f636b2068696d2e0a2d506f736569646f6e220a456c6f6e204d75736b27732058200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20250422141017_66f9f45d9b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

