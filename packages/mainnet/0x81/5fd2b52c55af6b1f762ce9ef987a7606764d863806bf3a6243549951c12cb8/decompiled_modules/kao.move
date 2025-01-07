module 0x815fd2b52c55af6b1f762ce9ef987a7606764d863806bf3a6243549951c12cb8::kao {
    struct KAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAO>(arg0, 9, b"KAO", b"KAONOAI", x"e9a194e381aee381aae3818420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5325411-5a8c-424d-8794-9c80c7829aab-IMG_4013.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

