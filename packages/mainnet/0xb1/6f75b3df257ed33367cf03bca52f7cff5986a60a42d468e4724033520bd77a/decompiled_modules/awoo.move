module 0xb16f75b3df257ed33367cf03bca52f7cff5986a60a42d468e4724033520bd77a::awoo {
    struct AWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWOO>(arg0, 9, b"AWOO", b"Awoo Cat", b"cats will make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bad87a61-87cc-4ee8-a173-58f85c158adc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

