module 0x9ad07b774003d63275a15e3a0f2be1c928d7aae5fcfb086e7d49a41ba02da9ea::swdb {
    struct SWDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWDB>(arg0, 6, b"SWDB", b"Sui Wallet Detector Bot", x"5375692077616c6c6574206465746563746f7220626f74206973206120626f7420746861742063616e20747261636b20616c6c207479706573206f66207472616e73616374696f6e7320737563682061730a0a2d204465762077616c6c657420686f6c64696e672f736f6c640a2d20436f6e6e65637465642077616c6c65742077697468206465762077616c6c65740a2d205768616c65732062757965720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_174316_142_0d1b544450.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

