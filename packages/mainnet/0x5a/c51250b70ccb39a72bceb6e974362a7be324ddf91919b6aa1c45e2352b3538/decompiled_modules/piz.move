module 0x5ac51250b70ccb39a72bceb6e974362a7be324ddf91919b6aa1c45e2352b3538::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZ>(arg0, 9, b"PIZ", b"Pizza", b"Only token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f525e6d4-8527-4d79-8040-7260b751a62f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

