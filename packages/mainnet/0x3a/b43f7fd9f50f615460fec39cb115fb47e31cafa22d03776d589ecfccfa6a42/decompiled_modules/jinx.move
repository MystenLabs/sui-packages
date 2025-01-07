module 0x3ab43f7fd9f50f615460fec39cb115fb47e31cafa22d03776d589ecfccfa6a42::jinx {
    struct JINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINX>(arg0, 9, b"JINX", b"JINZ", b" X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f90b800-00f3-4012-860b-30bff17f1808.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINX>>(v1);
    }

    // decompiled from Move bytecode v6
}

