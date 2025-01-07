module 0xe4e15a8e90a8d5538e466f7425bad3ac474a55d0fb4ec4cb260f559d3c69dd14::kiwi {
    struct KIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIWI>(arg0, 6, b"KIWI", b"KIWI BRIDSUI", b"KIWI BRIDS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Coin_1_40ee5454b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

