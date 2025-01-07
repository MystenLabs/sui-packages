module 0x578a9cbfaa7db3ca79b399313102c4f242421cc81590f2fd5afd01c19a683f7b::spenguin {
    struct SPENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENGUIN>(arg0, 6, b"Spenguin", b"suipenguin", b"Searching! A runaway baby penguin! Baby penguin: I'm angry. It can't be coaxed well!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015590_fe5447d207.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

