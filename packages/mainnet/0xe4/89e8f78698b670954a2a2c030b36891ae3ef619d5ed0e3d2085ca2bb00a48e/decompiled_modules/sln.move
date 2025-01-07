module 0xe489e8f78698b670954a2a2c030b36891ae3ef619d5ed0e3d2085ca2bb00a48e::sln {
    struct SLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLN>(arg0, 9, b"SLN", b"SuiElon", b"Elon Meme Coin on Sui ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7dade05d-181f-41aa-8829-1ae42f05a7d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

