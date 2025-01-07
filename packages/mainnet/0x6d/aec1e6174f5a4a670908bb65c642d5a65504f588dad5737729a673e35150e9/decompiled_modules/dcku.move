module 0x6daec1e6174f5a4a670908bb65c642d5a65504f588dad5737729a673e35150e9::dcku {
    struct DCKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKU>(arg0, 9, b"DCKU", b"DuckyDuck", b"Token for human love duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e76bdcf-0bc9-4d42-84aa-bd7624eededd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

