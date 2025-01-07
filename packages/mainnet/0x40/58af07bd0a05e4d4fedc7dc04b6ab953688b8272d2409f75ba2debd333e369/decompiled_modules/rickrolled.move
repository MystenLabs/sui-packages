module 0x4058af07bd0a05e4d4fedc7dc04b6ab953688b8272d2409f75ba2debd333e369::rickrolled {
    struct RICKROLLED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKROLLED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKROLLED>(arg0, 6, b"RICKROLLED", b"Rickrolled", b"Careful with dem links", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/07_rickrolled_de28985d64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKROLLED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKROLLED>>(v1);
    }

    // decompiled from Move bytecode v6
}

