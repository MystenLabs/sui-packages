module 0xcd463bcf6647766a1f5a91c093509c69c3e054b94cd58614e332126a3f5277f5::jn {
    struct JN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JN>(arg0, 9, b"JN", b"Social ", b"Coconut milk and coconut cream ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60f0cd86-2dc8-4c60-8cff-85ec7881c07b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JN>>(v1);
    }

    // decompiled from Move bytecode v6
}

