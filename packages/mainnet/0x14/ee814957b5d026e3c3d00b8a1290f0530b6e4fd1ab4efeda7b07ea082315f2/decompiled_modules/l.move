module 0x14ee814957b5d026e3c3d00b8a1290f0530b6e4fd1ab4efeda7b07ea082315f2::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 9, b"L", b"lady", b"lady are beautiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b24f47b4-e2f5-4f15-aa90-9ca0ea00be23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
    }

    // decompiled from Move bytecode v6
}

