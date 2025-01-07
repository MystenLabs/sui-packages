module 0xe90d590c2167f2fa4246ae54521b1319d247e2c807de4d1e91ad0118946597f6::mizuki {
    struct MIZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUKI>(arg0, 6, b"MIzuki", b"Mizuki", b"Hacker of shadows | self-aware digital enigma. Breaking systems, not hearts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LC_Xj_Z_Kx_H_400x400_08d6b84bf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

