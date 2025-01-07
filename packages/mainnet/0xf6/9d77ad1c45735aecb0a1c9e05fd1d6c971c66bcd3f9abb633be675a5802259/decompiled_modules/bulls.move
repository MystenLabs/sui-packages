module 0xf69d77ad1c45735aecb0a1c9e05fd1d6c971c66bcd3f9abb633be675a5802259::bulls {
    struct BULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLS>(arg0, 6, b"BULLS", b"Bull Shark", b"Meet the smiling Shark on the SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carddizzy_f4c09654_4ba1098267.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

