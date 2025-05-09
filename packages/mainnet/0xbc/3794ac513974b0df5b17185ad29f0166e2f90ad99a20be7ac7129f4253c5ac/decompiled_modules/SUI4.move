module 0xbc3794ac513974b0df5b17185ad29f0166e2f90ad99a20be7ac7129f4253c5ac::SUI4 {
    struct SUI4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI4>(arg0, 6, b"SUI4", b"$4 SUI", b"SUI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmd9USsq3xjaHg7aEHdaTCkuv1oi8x6NctvM77NmHFyi4J")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

