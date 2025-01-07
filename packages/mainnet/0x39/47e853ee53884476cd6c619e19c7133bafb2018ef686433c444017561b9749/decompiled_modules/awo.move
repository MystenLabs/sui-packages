module 0x3947e853ee53884476cd6c619e19c7133bafb2018ef686433c444017561b9749::awo {
    struct AWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWO>(arg0, 9, b"AWO", b"awo cat", b"Awo the cat is meme based on cat saying awo in the internet,more update soon!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4294be8c-8ad6-4545-a16f-7441c03b65c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

