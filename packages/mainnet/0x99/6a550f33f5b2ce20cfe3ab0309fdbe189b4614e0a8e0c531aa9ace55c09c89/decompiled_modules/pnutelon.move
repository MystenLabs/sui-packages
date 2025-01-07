module 0x996a550f33f5b2ce20cfe3ab0309fdbe189b4614e0a8e0c531aa9ace55c09c89::pnutelon {
    struct PNUTELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTELON>(arg0, 6, b"PNUTELON", b"PNut Not Alone", x"456172746820646f65736e2774206465736572766520504e5554200a42757420456c6f6e27732053554920706c616e657420646f657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000527823_393a3450da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

