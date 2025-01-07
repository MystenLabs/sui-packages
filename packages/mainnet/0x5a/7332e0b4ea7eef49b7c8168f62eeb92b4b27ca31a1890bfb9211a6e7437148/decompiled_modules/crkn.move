module 0x5a7332e0b4ea7eef49b7c8168f62eeb92b4b27ca31a1890bfb9211a6e7437148::crkn {
    struct CRKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRKN>(arg0, 9, b"CRKN", b"Cracken", b"Ocean giant octopas new era of ocean king meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a974176e-1664-4762-9fab-43320c015a3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

