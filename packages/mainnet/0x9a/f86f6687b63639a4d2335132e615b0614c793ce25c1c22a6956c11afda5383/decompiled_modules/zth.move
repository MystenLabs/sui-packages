module 0x9af86f6687b63639a4d2335132e615b0614c793ce25c1c22a6956c11afda5383::zth {
    struct ZTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZTH>(arg0, 9, b"ZTH", b"Zheter ", x"d0a2d0bed0bad0b5d0bd20d0bdd0b020d0b1d0bbd0bed0bad187d0b5d0b9d0bdd0b5205369676e756d2e6e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfb2877e-fffb-42c0-bf6b-4c7f76e99b03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

