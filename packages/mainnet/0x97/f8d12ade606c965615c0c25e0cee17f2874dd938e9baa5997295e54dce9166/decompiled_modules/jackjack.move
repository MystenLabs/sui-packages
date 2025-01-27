module 0x97f8d12ade606c965615c0c25e0cee17f2874dd938e9baa5997295e54dce9166::jackjack {
    struct JACKJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKJACK>(arg0, 6, b"JACKJACK", b"SUIjackjack", b"your favorite baby superhero is ready to take you to the moon supermemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_Jack_98b298f7bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKJACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

