module 0x56740e6ee39f725cfc8567a8ac3d34b82873e3cc99d3835c41afdd5ed76b339::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"FLUFFY ON SUI", b"otally agree! $SUI is killing it with its game-changing features in Web3. While youre diving into all the innovations, dont sleep on $FLUFFY, the cute penguin meme coin on Sui. Its picking up steam and adding some fun to the ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0571_1a62a4020e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

