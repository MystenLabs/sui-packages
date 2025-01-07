module 0x8c54790bbb857b5d2afef6f2675552a1fa140757525a4080d3d5b3b8af620227::vmh {
    struct VMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VMH>(arg0, 9, b"VMH", b"vmhoangit", b"vmhoangit1408", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb5fe6db-551f-4b8f-87ca-04a589438f55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

