module 0x85282bf1089ab4e2a3949fc80a108e53508c3ac4645883975d64b08f69b86eb7::slp_wvn {
    struct SLP_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLP_WVN>(arg0, 9, b"SLP_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0afc0c7a-d0c9-4a93-88ad-b59007274c75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLP_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLP_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

