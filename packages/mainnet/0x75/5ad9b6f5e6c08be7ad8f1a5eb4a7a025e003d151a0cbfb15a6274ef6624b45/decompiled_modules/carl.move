module 0x755ad9b6f5e6c08be7ad8f1a5eb4a7a025e003d151a0cbfb15a6274ef6624b45::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARL>(arg0, 6, b"Carl", b"The Moon", b" \" Early buyers will become millionaires !!!! \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/the_moon_b4cd57ef79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

