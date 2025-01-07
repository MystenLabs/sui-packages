module 0x2427dc2b51453823ed2f0362da6395fd6a929b96a1d4cc71aeff11eed68725ac::chui {
    struct CHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUI>(arg0, 6, b"CHUI", b"ChopSui", b"Just little Chui trying to eat some Chop Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036439_6fb4a110ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

