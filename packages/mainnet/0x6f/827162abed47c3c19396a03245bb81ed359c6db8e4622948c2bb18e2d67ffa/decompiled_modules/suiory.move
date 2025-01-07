module 0x6f827162abed47c3c19396a03245bb81ed359c6db8e4622948c2bb18e2d67ffa::suiory {
    struct SUIORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORY>(arg0, 6, b"SUIORY", b"$SUIORY", b"Suiory  has also finally been found this fish is here to stay and wont swim away! - on the $SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiory_b88c95b7c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

