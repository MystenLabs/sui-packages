module 0x1b79c4bb2aa4ecbca43a8691b700151a2d553de5a13e85ce46d220a34ac705fc::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGI>(arg0, 9, b"AGI", b"Agent G", b"Agent G - 10010100111101101111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.pixabay.com/photo/2017/11/16/09/32/matrix-2953869_1280.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AGI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

