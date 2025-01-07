module 0xee13e8c58e6312f19de5ba5b0ada701f7c389c364e00fa44602ee950c744254::tos {
    struct TOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOS>(arg0, 9, b"TOS", b"Trillion", b"Trillion Dollars On Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41e10b99-b86e-4dfb-9b27-406a4da01f0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

