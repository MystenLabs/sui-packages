module 0x2e0e4bc969bb88fcb11ebb4f27cbd67dae2d5d50b95f2626476c507476fdf567::mdg {
    struct MDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDG>(arg0, 6, b"MDG", b"MoveDoge", b"Hop on before the rocket takes off!  MoveDoge ($MDG) is the meme token set to dominate the Sui network. With Doge's charisma and the power of Move technology, it's ready to soar straight to the moon! Don't miss out on this epic ride  join the hype before it's too late!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Move_Doge_Logo_496894f033.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

