module 0x492622bfe3799b37a478a4078e4af22d67307e198b3dac95e1f3fbbea6f4c4e1::d_ung {
    struct D_UNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_UNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D_UNG>(arg0, 9, b"D_UNG", b"dungnguyen", b"meme in the star", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a6579f5-fb7b-4c41-a274-cde853ee87af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D_UNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D_UNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

