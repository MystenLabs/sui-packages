module 0x4b63cd2b01b10f7959aee087cb174d5a2ec37c4b53ae30e3c54f379f5254d5c0::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"BUNKER", b"The apocalypse is coming. Save yourself while you can. Enter $BOB's bunker and survive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunk_bca020454b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

