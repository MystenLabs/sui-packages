module 0x496d3a371564f0d1d50249dcfa22f4bb21674c2cac2181a6bcd74a96e88ec00::rte {
    struct RTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTE>(arg0, 9, b"RTE", x"526563657020546179796970204572646fc49f616e", b"The best president ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/94142876eeac36646e89f8a336355ba6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

