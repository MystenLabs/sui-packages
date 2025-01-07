module 0x48714580f5f55859e4cd43f1ee2517999e0a3872f199bb4e6c8fdf29e8d76500::draggy {
    struct DRAGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGGY>(arg0, 6, b"DRAGGY", b"Draggy On Sui", b"Meet $Draggy, protector of Hoppy in The Night Riders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_92f5f2707d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

