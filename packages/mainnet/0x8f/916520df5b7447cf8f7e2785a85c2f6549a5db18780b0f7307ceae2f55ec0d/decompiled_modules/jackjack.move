module 0x8f916520df5b7447cf8f7e2785a85c2f6549a5db18780b0f7307ceae2f55ec0d::jackjack {
    struct JACKJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKJACK>(arg0, 6, b"JACKJACK", b"Suijackjack", b"your favorite baby superhero is ready to take you to the moon supermemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_Jack_a90742c96b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKJACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKJACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

