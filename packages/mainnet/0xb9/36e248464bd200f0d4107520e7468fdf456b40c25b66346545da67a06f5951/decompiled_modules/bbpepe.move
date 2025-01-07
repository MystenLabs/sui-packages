module 0xb936e248464bd200f0d4107520e7468fdf456b40c25b66346545da67a06f5951::bbpepe {
    struct BBPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBPEPE>(arg0, 9, b"BBPEPE", b"BBpepe", b"to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/e345d387-d55e-4b21-9dca-b0eb7717d7a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

