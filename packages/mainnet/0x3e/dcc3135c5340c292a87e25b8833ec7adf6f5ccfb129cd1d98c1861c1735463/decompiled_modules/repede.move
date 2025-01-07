module 0x3edcc3135c5340c292a87e25b8833ec7adf6f5ccfb129cd1d98c1861c1735463::repede {
    struct REPEDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPEDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPEDE>(arg0, 6, b"Repede", b"Repede Moon Coin", b"Its your failthful companion Repede here to take you to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Repede_To_The_Moon_6380b647ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPEDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REPEDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

