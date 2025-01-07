module 0x51b6e2d05dc11fc8f305e24cbcad59fa6b74e658bd028d55c1f37c9a52c5ffce::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 9, b"SS", b"ShibaShark", b"Shiba Shark Token is a meme-based cryptocurrency combining the playful spirit of Shiba Inu with the boldness of a shark. It's built for fun, community, and moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/847a947f-0358-4a67-bf6f-dff12c8adcc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

