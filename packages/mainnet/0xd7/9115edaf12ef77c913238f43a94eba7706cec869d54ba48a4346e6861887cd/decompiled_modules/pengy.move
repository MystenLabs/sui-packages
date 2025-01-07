module 0xd79115edaf12ef77c913238f43a94eba7706cec869d54ba48a4346e6861887cd::pengy {
    struct PENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGY>(arg0, 6, b"Pengy", b"Sui Penguin", b"Sui Penguin CTO. Welcome chads, Pengy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7002_3bc55fad8d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

