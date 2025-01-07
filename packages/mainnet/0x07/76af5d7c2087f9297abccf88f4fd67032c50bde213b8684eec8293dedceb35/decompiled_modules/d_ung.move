module 0x776af5d7c2087f9297abccf88f4fd67032c50bde213b8684eec8293dedceb35::d_ung {
    struct D_UNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_UNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D_UNG>(arg0, 9, b"D_UNG", b"dungnguyen", b"meme in the star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b2fb6df-6d24-4e6f-a1ea-a7808df66ec8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D_UNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D_UNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

