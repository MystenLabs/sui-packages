module 0xd73f15e1567e38bc0cd0f31d42a7ef65bf73043f30f83cdc91119b36b2d0c0c1::dgi {
    struct DGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGI>(arg0, 9, b"DGI", b"dogi", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e736824f-a897-40a3-a76e-07a47eaa7dea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

