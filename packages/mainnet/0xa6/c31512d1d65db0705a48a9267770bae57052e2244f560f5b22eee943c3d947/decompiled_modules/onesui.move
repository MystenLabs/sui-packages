module 0xa6c31512d1d65db0705a48a9267770bae57052e2244f560f5b22eee943c3d947::onesui {
    struct ONESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONESUI>(arg0, 6, b"OneSui", b"1 Sui and a Dream", b"1 Sui and a dream is all you need. Send this coin to bond and see it go to $1 million. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_20_at_12_48_50a_AM_fb58837928.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

