module 0x5be8fc647495ea6c186612e0f778e92206e0c25e47e342ff0e0a9132b72ad4eb::psy {
    struct PSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSY>(arg0, 6, b"PSY", b"Psyduck", b"The meme duck that survived a chain collapse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjcu2senl6xosofh7hzbrqgdbwwcmzpbt7bhv2lwoaaja7qfxrem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

