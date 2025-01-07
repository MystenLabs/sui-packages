module 0xdb6374afe8231bbee009a8c9f352b93a8cf6e577e33f7dfa9f58074d1bfcc2d5::pepepsui {
    struct PEPEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPSUI>(arg0, 6, b"PEPEPSUI", b"Pepe Sui", b"King of meme is pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028614_222e5397e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

