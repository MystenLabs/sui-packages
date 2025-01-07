module 0x7b1c4395a0e4159533bf6f7521e97a43bd8416acc268d1c83ae4219d17bc1ed0::zfr {
    struct ZFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFR>(arg0, 6, b"ZFR", b"ZIFRETTA", b"ZIFRETTA ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ebde9195_d977_4976_8f37_edb480e2b20e_57965cf8b2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

