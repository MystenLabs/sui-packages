module 0x92108eca1b14cae6967fa3639c67e0a01127dd31bf7b5926ac2096560d4e3e85::khk {
    struct KHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHK>(arg0, 9, b"KHK", b"kohaku", b"Introducing the new Toy Poodle meme coin! Embrace the playful spirit of our furry friends while joining a vibrant community of dog lovers and crypto enthusiasts. Get ready to fetch some fun and rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74c852db-43a2-49af-bb86-575ec07ab07d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

