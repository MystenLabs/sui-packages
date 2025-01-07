module 0x17bd9a2bc4c60dee35819870459aa5f20a19f8c0cfd01a28393da91c06c6e8df::stars {
    struct STARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARS>(arg0, 6, b"STARS", b"Ton Stars", x"5355492024535441525320697320612070726f6a6563742061696d656420617420646576656c6f70696e6720746f6f6c7320666f72207573657273206f6620746865200a5375690a202c20616c6f6e67736964652065737461626c697368696e67206974277320454c49544520434c554220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cjr8_Whz_400x400_ba12368a8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

