module 0xe1f71dd5851c768428f2f81fe844d58242a2e5158e7b0c2dba270c3c1b1630d7::hj {
    struct HJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJ>(arg0, 9, b"HJ", b"df", b"fsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ae01959-2999-4793-b578-c0144f46bbca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

