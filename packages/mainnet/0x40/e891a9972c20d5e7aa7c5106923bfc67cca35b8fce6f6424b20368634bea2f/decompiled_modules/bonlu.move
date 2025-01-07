module 0x40e891a9972c20d5e7aa7c5106923bfc67cca35b8fce6f6424b20368634bea2f::bonlu {
    struct BONLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONLU>(arg0, 9, b"BONLU", b"vetmang", b"BONLU4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3d6a453-da97-4511-a7e7-bfc3b91ca00b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

