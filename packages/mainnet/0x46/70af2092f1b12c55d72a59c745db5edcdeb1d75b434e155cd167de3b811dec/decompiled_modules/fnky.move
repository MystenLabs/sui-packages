module 0x4670af2092f1b12c55d72a59c745db5edcdeb1d75b434e155cd167de3b811dec::fnky {
    struct FNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNKY>(arg0, 9, b"FNKY", b"FUNKY", b"JUST MEME FOR US. LETS MAKE FUN FOR US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1fcccba-f5f5-4a79-b9a5-a4ed90c4bd1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

