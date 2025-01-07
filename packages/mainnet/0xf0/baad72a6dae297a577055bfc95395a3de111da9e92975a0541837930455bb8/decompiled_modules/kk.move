module 0xf0baad72a6dae297a577055bfc95395a3de111da9e92975a0541837930455bb8::kk {
    struct KK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KK>(arg0, 9, b"KK", b"Kansakali ", b"For fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c87b4efe-e1c8-43e9-bc6c-d68fd4aecd55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KK>>(v1);
    }

    // decompiled from Move bytecode v6
}

