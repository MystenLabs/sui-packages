module 0xd652d4d53d357612f4a4e37dc3ac2efa120f38a77ca99c9d218e2ec502866c6b::nmk {
    struct NMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMK>(arg0, 9, b"NMK", b"Namek", b"The most efficient solutions for web3. Update your score level. DBZ MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc7263f8-2188-4a5e-80c8-6c0773de0979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

