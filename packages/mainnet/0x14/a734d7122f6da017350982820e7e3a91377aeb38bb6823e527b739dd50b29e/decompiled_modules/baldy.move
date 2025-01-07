module 0x14a734d7122f6da017350982820e7e3a91377aeb38bb6823e527b739dd50b29e::baldy {
    struct BALDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDY>(arg0, 6, b"BALDY", b"BALDY SUI", b"Meet Baldy, the dog that's all bark and no hair! This bald dog is here to fetch you some laughs and maybe a fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6650_f62aec15e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

