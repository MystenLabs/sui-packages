module 0xd537f09fa189b2891f5f6c4f077efc1f49622ed9e2314c1249d3580486937849::vrs {
    struct VRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRS>(arg0, 9, b"VRS", b"Virus", b"Meme of Virus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0098b63a-ba8f-4180-895b-78e98126e3ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

