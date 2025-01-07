module 0x470ea54f1f448ba4d6cc04aa793692c7713fa6aab3c94785c71c17cbb47ca525::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"Seal", b"WOW such seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000041965_f2b8e39793.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

