module 0xa2decd1c242dedeecf164bacdae088ae158a7f104259df812e8994b454fe1fdb::tux {
    struct TUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUX>(arg0, 6, b"TUX", b"Sui Penguin", x"0a0a0a0a245455582c2074686520636861726d696e672070656e6775696e2066726f6d20746865204172637469632c20776164646c696e67206869732077617920746f207468652053756920426c6f636b636861696e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241017_170523_949_537a43bda3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

