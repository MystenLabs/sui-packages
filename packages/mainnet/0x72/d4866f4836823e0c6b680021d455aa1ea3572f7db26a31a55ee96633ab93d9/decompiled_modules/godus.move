module 0x72d4866f4836823e0c6b680021d455aa1ea3572f7db26a31a55ee96633ab93d9::godus {
    struct GODUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODUS>(arg0, 6, b"Godus", b"GODUS (ODDIH)", b"You missed sudog. $GODUS will surpass it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004201_77e9e74e25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

