module 0xf0aca046f013f0c2579f9045e4faccb1abdbc85cf53c0b91e09071b5c2e6ed2b::jorgie {
    struct JORGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORGIE>(arg0, 9, b"JORGIE", b"Jorgie", b"The meme is a monkey taken by police price replied by Tesla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9292a0a9-d437-4f73-a717-b62308a1e1b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JORGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

