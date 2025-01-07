module 0xbb4a2faa3af8f3043ecbd992f50c3155422c43b1f541b224251b92214594963f::ref {
    struct REF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REF>(arg0, 9, b"REF", b"red flower", b"RED FLOWERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81423f1d-753a-4a85-839f-8c9c118ded8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REF>>(v1);
    }

    // decompiled from Move bytecode v6
}

