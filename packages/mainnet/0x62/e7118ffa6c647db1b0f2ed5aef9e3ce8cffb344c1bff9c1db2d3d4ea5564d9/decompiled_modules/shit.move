module 0x62e7118ffa6c647db1b0f2ed5aef9e3ce8cffb344c1bff9c1db2d3d4ea5564d9::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"Shit", b"Shitcoin", x"426f6e6a6f7572206d657320616d6973202c206a652073756973207368697420746865206672656e63687920666f7220416d65726963616e206974732063726f697373616e7420200a4c652064656a61207675202e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000149248_a280fee0df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

