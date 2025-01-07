module 0x287b46a1dd4774b9166f5a0f2a70a48c8e17f0813f13ee6d683d4099fa71e763::rec {
    struct REC has drop {
        dummy_field: bool,
    }

    fun init(arg0: REC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REC>(arg0, 9, b"REC", b"Remember ", b"The only way you will ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebc05097-ea1d-4655-989f-acc5e9693570.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REC>>(v1);
    }

    // decompiled from Move bytecode v6
}

