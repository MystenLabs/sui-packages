module 0xa57e512e91e85cba45ed42f7435b3c8ac86b86a79df08fb0642c74209cc539b::th {
    struct TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH>(arg0, 9, b"TH", b"Coffee ", b"SMS and I right here in my ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5416bd0-b982-4120-8948-93e05e61c3d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

