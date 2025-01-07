module 0x73c98a6cf6e948d5cb7f3b05b037270600d96c016dffcbe6f4e5acf865d41bc7::hhj {
    struct HHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHJ>(arg0, 9, b"HHJ", b"Bjjg", b"Boss j hae", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/329c28ea-7c6d-4914-a09b-4644ab872d88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

