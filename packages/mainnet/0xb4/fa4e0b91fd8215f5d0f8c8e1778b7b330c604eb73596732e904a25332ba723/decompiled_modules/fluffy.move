module 0xb4fa4e0b91fd8215f5d0f8c8e1778b7b330c604eb73596732e904a25332ba723::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"FLUFFY ON SUI", b"otally agree! $SUI is killing it with its game-changing features in Web3. While youre diving into all the innovations, dont sleep on $FLUFFY, the cute penguin meme coin on Sui. Its picking up steam and adding some fun to the ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/000_3f4fe1eb3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

