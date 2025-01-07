module 0xfde00819ff19068ed1abd02273985dc12aa4005556055ce0c3a431a9fb2c0bb2::witchat {
    struct WITCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCHAT>(arg0, 6, b"Witchat", b"Suiwitchat", b"Witchat will give you a magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9766_88c6965419.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITCHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

