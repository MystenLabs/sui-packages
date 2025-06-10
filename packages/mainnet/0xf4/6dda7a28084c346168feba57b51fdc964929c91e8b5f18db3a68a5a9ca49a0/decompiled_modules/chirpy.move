module 0xf46dda7a28084c346168feba57b51fdc964929c91e8b5f18db3a68a5a9ca49a0::chirpy {
    struct CHIRPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRPY>(arg0, 6, b"CHIRPY", b"Sui Chirpy", x"5361792068656c6c6f20746f2043686972707920e28094207468652074696e696573742c2068617070696573742062697264206f6e207468652053756920626c6f636b636861696e2e205769746820676c6f77696e672066656174686572732c2062696720657965732c20616e6420656e646c657373206f7074696d69736d2c2024434849525059206973206e6f74206a757374206120636f696e3b20697427732061206d6f76656d656e74206f6620666c7566662c2066756e2c20616e642066726565646f6d2e2054686973206c6974746c65206269726420646f65736ee280997420464f4d4f20e2809420697420666c6965732066697273742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749520297670.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

