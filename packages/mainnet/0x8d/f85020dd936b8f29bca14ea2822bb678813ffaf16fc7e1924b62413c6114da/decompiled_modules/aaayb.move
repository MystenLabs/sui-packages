module 0x8df85020dd936b8f29bca14ea2822bb678813ffaf16fc7e1924b62413c6114da::aaayb {
    struct AAAYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAYB>(arg0, 6, b"AAAYB", b"AAAYBird", b"Well it looks like the popular meme \"AAA Yellow Bird\" is now on the Sui Network!   Join our Telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2982ef69a008160cb67ef0a0e8af43de_be28462ac7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAYB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

