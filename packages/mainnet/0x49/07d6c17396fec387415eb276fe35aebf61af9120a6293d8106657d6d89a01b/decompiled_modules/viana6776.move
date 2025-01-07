module 0x4907d6c17396fec387415eb276fe35aebf61af9120a6293d8106657d6d89a01b::viana6776 {
    struct VIANA6776 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIANA6776, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIANA6776>(arg0, 9, b"VIANA6776", b"NotPIX", b"A token that has a very bright future and is going to be used in a large ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7be66f17-a3b5-4bae-a2d7-ed26eec8d5e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIANA6776>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIANA6776>>(v1);
    }

    // decompiled from Move bytecode v6
}

