module 0x75f9b5d6419cdcef30a652eb0747ac76fdb0b5b8b3079a6360ee66246587f208::vky {
    struct VKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VKY>(arg0, 9, b"VKY", b"Vashaky", b"An outstandingly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/885dc260-4c8e-4aaa-a45e-8f2107e91e73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

