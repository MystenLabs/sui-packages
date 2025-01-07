module 0x95b537fa77b10d906f0bd7dc6e1bfa7710a96c4cd95890645bf235370ecc5bcd::bll {
    struct BLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLL>(arg0, 9, b"BLL", b"bullet", b"Fast and high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4717561-6963-422e-9fe7-0cb7bf004dcf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

