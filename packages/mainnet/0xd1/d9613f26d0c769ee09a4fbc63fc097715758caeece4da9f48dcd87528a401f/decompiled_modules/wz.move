module 0xd1d9613f26d0c769ee09a4fbc63fc097715758caeece4da9f48dcd87528a401f::wz {
    struct WZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZ>(arg0, 9, b"WZ", b"Wxyz", b"Alphabet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0de562ff-da43-40c5-b9ed-73fab4533da7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

