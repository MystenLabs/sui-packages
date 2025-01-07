module 0x5ec5d625355439f0398312b1754ac9b4568045da89a85009cab2d3b540822fb9::slp_wvn {
    struct SLP_WVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP_WVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLP_WVN>(arg0, 9, b"SLP_WVN", b"Wavern ", b"Simple wavern simple meme simple flow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad587af0-1068-4d07-b85f-63e3fe652369.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLP_WVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLP_WVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

