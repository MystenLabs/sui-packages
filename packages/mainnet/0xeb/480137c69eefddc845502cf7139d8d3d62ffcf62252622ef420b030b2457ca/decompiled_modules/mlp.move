module 0xeb480137c69eefddc845502cf7139d8d3d62ffcf62252622ef420b030b2457ca::mlp {
    struct MLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLP>(arg0, 9, b"MLP", b"MALUPITON", b"MALUPITON GOES TO MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a28845b8-e3d2-4716-bf1f-3bbfbce35080.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

