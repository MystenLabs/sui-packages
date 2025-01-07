module 0x681db267fb0ba60a8adff3da125987ee83aba87cffa89f566623fb16d2b9bece::spug {
    struct SPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUG>(arg0, 6, b"SPUG", b"PugSolar on SUI", b"$SPUG is easily one of the most undervalued hidden gems on  MovePump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JM_6rjo_y_400x400_4b123e3ca4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

