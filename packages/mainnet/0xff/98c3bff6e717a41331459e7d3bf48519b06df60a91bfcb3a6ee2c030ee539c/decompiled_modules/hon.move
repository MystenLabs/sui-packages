module 0xff98c3bff6e717a41331459e7d3bf48519b06df60a91bfcb3a6ee2c030ee539c::hon {
    struct HON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HON>(arg0, 9, b"HON", b"Honda civi", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be4e1b4c-9a19-4030-8f7e-d6180c503e2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HON>>(v1);
    }

    // decompiled from Move bytecode v6
}

