module 0x27f194097c8e85ec471712c3963865608b20bf371293106df4214c1e1cdb404::pikachu {
    struct PIKACHU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIKACHU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PIKACHU>>(0x2::coin::mint<PIKACHU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHU>(arg0, 9, b"PIKA", b"Pikachu", b"Pikachu Meme Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/017/787/280/large/annika-soljander-icons2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKACHU>>(v1);
    }

    // decompiled from Move bytecode v7
}

