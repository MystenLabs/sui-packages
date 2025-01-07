module 0xe2b6d51eaf8b48875d5a4723bad03c3af33eff99c131af084dbb554b5645bb43::ahjghjgjhg {
    struct AHJGHJGJHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHJGHJGJHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHJGHJGJHG>(arg0, 9, b"AHJGHJGJHG", b"ggtyuguytu", b"hfghjgjhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9e7c11e-79eb-4bd3-bf8a-02ad8e455ee0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHJGHJGJHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHJGHJGJHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

