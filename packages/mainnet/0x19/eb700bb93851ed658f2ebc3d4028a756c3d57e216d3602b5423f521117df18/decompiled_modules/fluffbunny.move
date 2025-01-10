module 0x19eb700bb93851ed658f2ebc3d4028a756c3d57e216d3602b5423f521117df18::fluffbunny {
    struct FLUFFBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFBUNNY>(arg0, 6, b"FluffBunny", b"SuiFluffBunny", b"Fluffbunny, which will be exhibited at Movepump, is not just a meme money, it is a revolution in the world of digital money! Inspired by the soft and cuddly nature of rabbits, Fluffbunny combines the playful appeal of meme culture with the excitement of cryptocurrency. It's time to jump into the future with the furriest coin on the block!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198777_52cc068714.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

