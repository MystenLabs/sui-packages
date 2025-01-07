module 0x112f82cdedb19a301f131313c087fd168e84aef0b0fd3721688f60bd7fc0ca55::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 9, b"RED", b"red eyed dog", b"brother of blue eyed dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RED>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RED>>(v1);
    }

    // decompiled from Move bytecode v6
}

