module 0x79745d5b156b29780d97599efcc483d4cc69d5a1cdb017655a76d0653f8a4e1::lk {
    struct LK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LK>(arg0, 9, b"LK", b"Lucky ", b"LUCKY stresses the role of chance in bringing about a favorable result.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f437d7e-5bf4-4f1e-a757-d0256134052c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LK>>(v1);
    }

    // decompiled from Move bytecode v6
}

