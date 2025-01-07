module 0x7f304c4291b7dbbf03a94333fa4cecd9b65b510547360afe4c353343c6bf95fb::watergirl {
    struct WATERGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERGIRL>(arg0, 6, b"Watergirl", b"Watergirl of Sui", b"Straight from the iconic Fireboy and Watergirl game, $WATERGIRL is here on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Watergirl_c3722d3ce7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

