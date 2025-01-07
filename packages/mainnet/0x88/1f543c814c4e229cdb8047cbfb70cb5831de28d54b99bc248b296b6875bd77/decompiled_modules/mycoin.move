module 0x881f543c814c4e229cdb8047cbfb70cb5831de28d54b99bc248b296b6875bd77::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 6, b"MYCOIN", b"MY COIN", b"Im holding MY COIN...if you buy, it will stop being MY COIN, it will be your MY COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2113428114_3c8c509872.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

