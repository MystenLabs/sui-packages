module 0x46aee41c854d558fa5bfebe66a3d58ee852d21f1c451d68105ade647ac7d2e13::spenguin {
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

