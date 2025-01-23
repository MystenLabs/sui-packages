module 0x9764ce6252ece7b0ad393f93f515962e89dfcf8f5feeef2ae2c95684114c6354::hmg {
    struct HMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMG>(arg0, 9, b"HMG", x"484d47f09faab7", b"HMG flower in VN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f53858c-95ba-4408-8104-e91fdfe4b485.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

