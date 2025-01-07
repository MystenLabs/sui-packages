module 0x12d46203fc74e42912b0fba90d1af5f0389cebc18a0f03d13b0bfe2f9ff2856::jwow9 {
    struct JWOW9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JWOW9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWOW9>(arg0, 9, b"JWOW9", b"jokowow", b"jokowow is joko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfed36b8-6231-4ec2-9546-0e6928a58aae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JWOW9>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JWOW9>>(v1);
    }

    // decompiled from Move bytecode v6
}

