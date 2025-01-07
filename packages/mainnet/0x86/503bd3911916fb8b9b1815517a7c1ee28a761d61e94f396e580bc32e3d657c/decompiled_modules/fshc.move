module 0x86503bd3911916fb8b9b1815517a7c1ee28a761d61e94f396e580bc32e3d657c::fshc {
    struct FSHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSHC>(arg0, 6, b"FSHC", b"Flying Smoking Hippo Cat", x"0a20496d206a757374206120466c79696e6720536d6f6b696e6720486970706f20436174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049965_1bc508ed2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSHC>>(v1);
    }

    // decompiled from Move bytecode v6
}

