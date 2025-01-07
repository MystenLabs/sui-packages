module 0xa6b98fcad75b8c4e6d14438550e807689ba7e1321784ba32cd3ad1b29c9e253::boombyonsui {
    struct BOOMBYONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOMBYONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOMBYONSUI>(arg0, 6, b"BoombyonSui", b"Boomby", b"BoombyonSui    X: @BoombyonSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a678c1643799566befd0e387600c446_6dc53f376a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOMBYONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOMBYONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

