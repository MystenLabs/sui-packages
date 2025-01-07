module 0xb22a15e031cb8ccdcb39e0f4d01e2bfd5b1edf680403013f8770766069abb21b::rt5 {
    struct RT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT5>(arg0, 9, b"RT5", b"Rat", b"Airdrop crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19259320-5540-451a-af59-61e1178f70ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

