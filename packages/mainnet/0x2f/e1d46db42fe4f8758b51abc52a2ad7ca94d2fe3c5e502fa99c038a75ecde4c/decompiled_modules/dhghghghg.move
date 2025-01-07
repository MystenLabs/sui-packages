module 0x2fe1d46db42fe4f8758b51abc52a2ad7ca94d2fe3c5e502fa99c038a75ecde4c::dhghghghg {
    struct DHGHGHGHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHGHGHGHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHGHGHGHG>(arg0, 9, b"DHGHGHGHG", b"gfgfgfgf", b"ghghghg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c187073-9c6b-494e-abe5-1cea18c0c336.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHGHGHGHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHGHGHGHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

