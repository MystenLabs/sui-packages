module 0xb63bacb77c34ba5f212fb030d8780c1bf285c56a6ada70818c66829035ce6fd5::abccddff {
    struct ABCCDDFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCCDDFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCCDDFF>(arg0, 9, b"ABCCDDFF", b"khashmmmm", b"memefi coin this is a coin based on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec1948f9-5e94-4d3a-8dc9-48b789ce98a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCCDDFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABCCDDFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

