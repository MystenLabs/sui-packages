module 0x699632f41ce2ae32eee48402d504ae98f81120ce66e127e01c6c00d80ef6fc0d::crunchie {
    struct CRUNCHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUNCHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUNCHIE>(arg0, 6, b"CRUNCHIE", b"CrunchieSUI", b" $CRUNCH  Devour Gains, Dunk on FOMO, and Get That Sweet Dough!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241130_091744_577_7dc4ae91d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUNCHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUNCHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

