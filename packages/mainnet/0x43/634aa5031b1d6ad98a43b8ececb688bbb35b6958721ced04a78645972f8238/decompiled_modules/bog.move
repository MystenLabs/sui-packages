module 0x43634aa5031b1d6ad98a43b8ececb688bbb35b6958721ced04a78645972f8238::bog {
    struct BOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOG>(arg0, 6, b"BOG", b"Bog", b"$BOG is Matt Furie's first frog character, created in 2004.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bog_3e39c5f744.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

