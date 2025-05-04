module 0x2e39f0ca727f18a4e0f042c4bd2b356642b3dc240c348cc4575588899628bbdb::erol {
    struct EROL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EROL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EROL>(arg0, 9, b"Erol", b"troltest", b"its a test just chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EROL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EROL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EROL>>(v1);
    }

    // decompiled from Move bytecode v6
}

