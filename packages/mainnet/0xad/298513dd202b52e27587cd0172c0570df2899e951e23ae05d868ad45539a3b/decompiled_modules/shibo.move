module 0xad298513dd202b52e27587cd0172c0570df2899e951e23ae05d868ad45539a3b::shibo {
    struct SHIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBO>(arg0, 6, b"SHIBO", b"My Shibo", b"The Cutest Meme Coin On Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086268_cc3ff5603e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

