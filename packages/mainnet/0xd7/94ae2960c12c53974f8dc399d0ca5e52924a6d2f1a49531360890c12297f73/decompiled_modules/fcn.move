module 0xd794ae2960c12c53974f8dc399d0ca5e52924a6d2f1a49531360890c12297f73::fcn {
    struct FCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCN>(arg0, 9, b"FCN", b"4Chan", b"we are the origin of all memes, this four leaf clover is no coincidence .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e78b9da-c6fe-4342-ab7c-29185d426e5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

