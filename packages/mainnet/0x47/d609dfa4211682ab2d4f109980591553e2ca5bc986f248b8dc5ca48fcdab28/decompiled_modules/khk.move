module 0x47d609dfa4211682ab2d4f109980591553e2ca5bc986f248b8dc5ca48fcdab28::khk {
    struct KHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHK>(arg0, 9, b"KHK", b"kohaku", b"Introducing the new Toy Poodle meme coin! Embrace the playful spirit of our furry friends while joining a vibrant community of dog lovers and crypto enthusiasts. Get ready to fetch some fun and rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1e25c6d-606d-46b9-bc92-4a3dc0fa186c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

