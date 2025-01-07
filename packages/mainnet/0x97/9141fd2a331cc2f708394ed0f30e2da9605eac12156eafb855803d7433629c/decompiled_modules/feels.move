module 0x979141fd2a331cc2f708394ed0f30e2da9605eac12156eafb855803d7433629c::feels {
    struct FEELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEELS>(arg0, 6, b"FEELS", b"FEELS MEME", b"Let's make Wojak and Meme Great Again on SUI ! Since, there is uncertainity on the market, FEELS MEME come up from wave.  Let's ride the trend together. $FEELS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_20_51_30_a2786814cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

