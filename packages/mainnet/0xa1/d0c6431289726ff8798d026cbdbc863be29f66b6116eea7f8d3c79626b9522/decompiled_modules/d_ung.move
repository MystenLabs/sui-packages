module 0xa1d0c6431289726ff8798d026cbdbc863be29f66b6116eea7f8d3c79626b9522::d_ung {
    struct D_UNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_UNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D_UNG>(arg0, 9, b"D_UNG", b"dungnguyen", b"meme in the star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01de1fcc-6fa1-4ea6-81e0-dec89d4fb1ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D_UNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D_UNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

