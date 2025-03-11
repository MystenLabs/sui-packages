module 0x242ddc526b9cb75513bee2fc629e01d5b7dc6da4c02d39cdab0160794635334f::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 9, b"CETUS-SUI Vault LPT", b"CETUS-SUI Haedal Vault LP Token", b"Haedal Vault LP Token, CETUS-SUI Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/wDk5NmfNJXk2yT_ocfN3UuYtAltpTjGGr-MQzPNl9E0")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

