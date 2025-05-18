module 0x799ba0b0cd3fb4b1e8b6afe3a6f74d994437f2d43bf61e3b34bb8b4a6f66ef50::tosh {
    struct TOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSH>(arg0, 9, b"Tosh", b"Toshie", x"546f736869652069732061207265766f6c7574696f6e617279206d656d6520746f6b656e20626f726e2066726f6d2074686520737069726974206f6620636f6d6d756e6974792c2066696e616e6369616c2066726565646f6d2c20616e642069727265707265737369626c6520696e7465726e65742068756d6f722e20496e7370697265642062792069636f6e6963206d656d652063756c7475726520616e642074686520666561726c65737320e2809c646567656ee2809d207370697269742c20546f73686965206973206d6f7265207468616e206a757374206120636f696ee280946974e28099732061206d6f76656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/186befb1affe4e8206780a442e4ab2d4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOSH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

