module 0x567d385f7b15097ceb850f7f46ad8b2388924139de5aa8d7e488efa38a622b30::fat {
    struct FAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAT>(arg0, 6, b"FAT", b"Fatso", b"Fatso, a Sui meme trader lives by the saying \"There is no nobility in poverty! I've been a rich whale & I have been a poor whale & I choose rich every F#cking time!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rekt_306edfce88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

