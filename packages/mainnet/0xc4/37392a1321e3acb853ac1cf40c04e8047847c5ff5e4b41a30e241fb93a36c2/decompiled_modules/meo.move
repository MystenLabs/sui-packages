module 0xc437392a1321e3acb853ac1cf40c04e8047847c5ff5e4b41a30e241fb93a36c2::meo {
    struct MEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEO>(arg0, 9, b"MEO", b"Meo", b"a cat ready to prey on a greedy mouse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd5411de-62fb-43f2-ab9e-2d0cb46d33aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

