module 0x2b989383f06f59597ef3ccfe641c721ff39fa0a1697e1316daee4ec39cb03e18::sbvjhgkjgh {
    struct SBVJHGKJGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBVJHGKJGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBVJHGKJGH>(arg0, 9, b"SBVJHGKJGH", b"hjgkjgku", b"hfkjyhf,jfy,fg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3547192-90df-4c0f-a95c-a66a0de794fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBVJHGKJGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBVJHGKJGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

