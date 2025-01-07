module 0xec7f4792c795164d3dee3263dc48965778f5812a0ab30da39db788a17a553d35::empty {
    struct EMPTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMPTY>(arg0, 6, b"EMPTY", b"EMPTY", b"Perhaps there was a description, but it was swallowed up by emptiness...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/6Jd73MK/emptylogo111111111111.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EMPTY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMPTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

