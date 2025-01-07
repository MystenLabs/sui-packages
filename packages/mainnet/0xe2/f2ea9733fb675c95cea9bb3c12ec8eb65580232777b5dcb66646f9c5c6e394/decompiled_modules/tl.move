module 0xe2f2ea9733fb675c95cea9bb3c12ec8eb65580232777b5dcb66646f9c5c6e394::tl {
    struct TL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TL>(arg0, 6, b"Tl", b"Tyler", b"Tyler is the fictional legendary character from Fatt Murie's Guys' Club comic. He is also a dancer and loves video games just as much as $BRETT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/floating_cloud_438cb87698.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TL>>(v1);
    }

    // decompiled from Move bytecode v6
}

