module 0x98707524ba4acc93346a971000ff61cb9c501192521f4f6ef6691091f876121b::bearg {
    struct BEARG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARG>(arg0, 6, b"BEARG", b"Bear Grow", b"$BEARG is a mix of \"BEAR\" and \"GROW\"!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033927_6ed7905fc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARG>>(v1);
    }

    // decompiled from Move bytecode v6
}

