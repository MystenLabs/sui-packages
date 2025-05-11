module 0x7461029d0b4d316461d50526646b7bf51e30056d16a2f57f6cfb1ab5e4ce2056::tun {
    struct TUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUN>(arg0, 6, b"TUN", b"TunCoin", b"Welcome to the world of $TUNCOIN, where memes meet the moon! We are not just another cryptocurrency; we are a global revolution led by the mighty Ant Army. Our mission is simple: to take the meme world by storm and achieve a 100x moonshot, bringing fun, community, and of course, epic gains to everyone involved.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068761_fe93be02ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

