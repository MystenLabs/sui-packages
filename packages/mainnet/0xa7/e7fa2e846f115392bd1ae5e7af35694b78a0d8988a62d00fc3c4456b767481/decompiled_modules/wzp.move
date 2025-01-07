module 0xa7e7fa2e846f115392bd1ae5e7af35694b78a0d8988a62d00fc3c4456b767481::wzp {
    struct WZP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZP>(arg0, 9, b"WZP", b"Wazzap", b"Wazzap will concuqre the world!  Buy it now and in 10 years you will be millionate, trust me! 5$ today - 500.000$ in 10 years! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6327fb2-3742-4e17-b748-335e010a7fdc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZP>>(v1);
    }

    // decompiled from Move bytecode v6
}

