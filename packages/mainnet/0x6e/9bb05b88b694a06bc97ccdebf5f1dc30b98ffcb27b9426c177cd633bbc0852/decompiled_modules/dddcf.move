module 0x6e9bb05b88b694a06bc97ccdebf5f1dc30b98ffcb27b9426c177cd633bbc0852::dddcf {
    struct DDDCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDCF>(arg0, 9, b"DDDCF", b"Dinhdong", b"Bao xin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69010c84-2d97-4f4f-b0e3-e25d09d37013.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDDCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

