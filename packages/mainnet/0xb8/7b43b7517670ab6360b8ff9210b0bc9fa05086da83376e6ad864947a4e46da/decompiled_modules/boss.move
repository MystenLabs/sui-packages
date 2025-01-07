module 0xb87b43b7517670ab6360b8ff9210b0bc9fa05086da83376e6ad864947a4e46da::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"Sui Boss", b"The top dog of the Sui Network. $BOSS calls the shots and sets the rules. Step up, show respect, and roll with the one who runs the show.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_74_aa240a6d05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

