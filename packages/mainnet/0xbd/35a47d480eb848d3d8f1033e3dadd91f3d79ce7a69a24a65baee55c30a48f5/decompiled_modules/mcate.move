module 0xbd35a47d480eb848d3d8f1033e3dadd91f3d79ce7a69a24a65baee55c30a48f5::mcate {
    struct MCATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCATE>(arg0, 6, b"MCATE", b"MOON CATE", b"MOONCATE brings strong energy with our leadership and the developer team has had many successful projects, bringing huge profits and joy to investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726732380154_479518ab1abfc521b8883ee95d204618_4da5ce55ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

