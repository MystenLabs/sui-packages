module 0x807caf5a5769c4312eac4cf7d3fa55d09cc6d8eee7bcf9319166c656362ae27a::r_sgm {
    struct R_SGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_SGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_SGM>(arg0, 9, b"R_SGM", b"Ryan sigma", b"This is meme friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ae578d7-6e40-4a20-9f66-f725e0d0ef49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_SGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R_SGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

