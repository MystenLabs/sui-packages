module 0x4737ba22e4eaaf7b34a11817b648e16e1c090b0e3530b6fbb143de266649a68e::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LION>(arg0, 6, b"Lion", b"LionCat", b"Meet LionCat, the crypto sensation thats roaring with cuteness and prowling the blockchain like a boss! This cats got more swagger than a lion in a tutu. Get ready to LOL your way to financial greatness with the fluffiest currency in town!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1741728992057_pic_8fa244e34d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LION>>(v1);
    }

    // decompiled from Move bytecode v6
}

