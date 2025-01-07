module 0x5501d9c53e61e419c9d386e736e36af5d00998a543167921206cb04fccb9b87c::vc {
    struct VC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VC>(arg0, 9, b"VC", b"ZXC", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dffde9d4-1cba-4b16-84a5-d5d7642ddb96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VC>>(v1);
    }

    // decompiled from Move bytecode v6
}

