module 0x5af0085547f5ea42c9057bf65ca8fff9bcc92edbf5bdf8b9e82ca683377eab5d::wryon {
    struct WRYON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRYON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRYON>(arg0, 6, b"WRYON", b"Sui Wryon", b"Welcome to wryon world: no rules, just chaos, carnage and coin the flip, human falter, trolls stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013409_3655571e42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRYON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRYON>>(v1);
    }

    // decompiled from Move bytecode v6
}

