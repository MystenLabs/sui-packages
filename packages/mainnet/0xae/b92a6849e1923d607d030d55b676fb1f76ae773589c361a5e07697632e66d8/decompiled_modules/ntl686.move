module 0xaeb92a6849e1923d607d030d55b676fb1f76ae773589c361a5e07697632e66d8::ntl686 {
    struct NTL686 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTL686, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTL686>(arg0, 9, b"NTL686", b"Dragon ", b"when whales fly i like it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/303152ed-e013-4ec4-b0fd-766b534c4e0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTL686>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTL686>>(v1);
    }

    // decompiled from Move bytecode v6
}

