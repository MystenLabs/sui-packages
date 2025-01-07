module 0xb952ef70143330231fc025a2da809dee58330e615ea7d50aaa7b756bf4829e1::pflw {
    struct PFLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFLW>(arg0, 9, b"PFLW", b"pinkflower", x"496e7370697265642062792074686520656c6567616e6365206f662070696e6b20666c6f77657273f09f8cb8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7abcd02-d23b-4471-be14-c632553394bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PFLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

