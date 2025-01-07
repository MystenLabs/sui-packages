module 0x43ee887e79c3df51cc7b19412d8b26d9d73658aa4f3e77343f13e9ffa2bc6f7c::carlo {
    struct CARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARLO>(arg0, 6, b"CARLO", b"CARLO SUI", b"Carlo is a clinically insane dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u246_H9_HN_400x400_acaab7727c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

