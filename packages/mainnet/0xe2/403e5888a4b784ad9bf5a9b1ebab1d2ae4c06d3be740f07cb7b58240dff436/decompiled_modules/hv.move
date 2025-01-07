module 0xe2403e5888a4b784ad9bf5a9b1ebab1d2ae4c06d3be740f07cb7b58240dff436::hv {
    struct HV has drop {
        dummy_field: bool,
    }

    fun init(arg0: HV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HV>(arg0, 9, b"HV", x"48c3aa6e2056c3a369", x"5875692076c3a369", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e578b2d5-30be-4cda-9c13-ca97413eacc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HV>>(v1);
    }

    // decompiled from Move bytecode v6
}

