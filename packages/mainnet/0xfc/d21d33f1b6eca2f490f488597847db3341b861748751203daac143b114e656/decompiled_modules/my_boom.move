module 0xfcd21d33f1b6eca2f490f488597847db3341b861748751203daac143b114e656::my_boom {
    struct MY_BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_BOOM>(arg0, 9, b"myboom", b"my boom", b"love boom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_BOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_BOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

