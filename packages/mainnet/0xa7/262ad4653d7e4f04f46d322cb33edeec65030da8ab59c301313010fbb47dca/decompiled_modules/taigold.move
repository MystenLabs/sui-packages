module 0xa7262ad4653d7e4f04f46d322cb33edeec65030da8ab59c301313010fbb47dca::taigold {
    struct TAIGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAIGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAIGOLD>(arg0, 9, b"TAIGOLD", b"TAINERGOLD", b"Meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23858d98-4476-4394-bfe6-394475ec43ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAIGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAIGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

