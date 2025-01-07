module 0x8b276b15ef19f081cce8a87bc361998cb09276392fc072e9c7be929636b6529::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 6, b"BBC", b"Bitcoin Block Cat", b"Block #186120 = Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitcoin_Block_Cat_1c2a69a1bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

