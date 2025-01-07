module 0x1a3e97d483856d11b07b95da2967156383e7ef2e5e875f332ee1dc63434ab74e::eh {
    struct EH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EH>(arg0, 9, b"EH", b"Ehh", x"4e6f7420696d707265737365643f204e65697468657220697320456820436f696e2e20466f722074686520756e626f74686572656420616e6420756e696d707265737365642c207468697320636f696e206973206173206368696c6c206173207468657920636f6d652e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69730476-d743-4d7e-97fb-bc4f666b5c9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EH>>(v1);
    }

    // decompiled from Move bytecode v6
}

