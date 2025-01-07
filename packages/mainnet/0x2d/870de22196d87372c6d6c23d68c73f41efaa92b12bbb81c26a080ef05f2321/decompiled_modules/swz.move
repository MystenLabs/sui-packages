module 0x2d870de22196d87372c6d6c23d68c73f41efaa92b12bbb81c26a080ef05f2321::swz {
    struct SWZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWZ>(arg0, 6, b"SWZ", b"SuperWeedz", b"Weed that flys you pass Uranus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_423178362490710_87b6e07e8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

