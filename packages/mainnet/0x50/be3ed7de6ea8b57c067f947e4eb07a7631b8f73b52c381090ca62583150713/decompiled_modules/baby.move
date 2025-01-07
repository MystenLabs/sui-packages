module 0x50be3ed7de6ea8b57c067f947e4eb07a7631b8f73b52c381090ca62583150713::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 6, b"BABY", b"Baby sui", b"Baby $Sui Coin is busy working in the background, let's have some fun!  Announcing the Baby Sui Meme Contest! Drop your funniest memes with Baby Sui reference,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d91ef908_d3a9_45d3_a01f_9bfc8f26c6cd_ae4370a212.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

