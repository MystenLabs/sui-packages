module 0x85d8296ea40488d1f26980b965b76149d69e0626e820bfa52e0362cf88856e35::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"Fluffy", b"Totally agree! $SUI is killing it with its game-changing features in Web3. While youre diving into all the innovations, dont sleep on $FLUFFY, the cute penguin meme coin on Sui. Its picking up steam and adding some fun to the ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fu_8bcc1d955b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

