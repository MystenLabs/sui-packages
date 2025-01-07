module 0x21b80fd24c90b0283d6f99278b2aea5ece42a1287200a4854238d1f487e1c668::rt5 {
    struct RT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT5>(arg0, 9, b"RT5", b"Rat", b"Airdrop crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f2a0e7e-8aeb-426d-b973-618b95191a55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

