module 0x7bf6e7e082b5ae002a2ae078b4166bbfed29f890c26303bfb4cabe73b1b28952::suidward {
    struct SUIDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDWARD>(arg0, 6, b"SUIDWARD", b"SUIDWARD TENTACLES", b"$SUIDWARD the grumpy genius of SUI, slapping charts and sucking at life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logotg_6839a43776.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

