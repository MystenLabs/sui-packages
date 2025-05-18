module 0xd9aab3149c49e334156d5c76784f897c5c3922802f9a2df252cc1f1af8a7e78a::skhjf {
    struct SKHJF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKHJF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKHJF>(arg0, 9, b"SKHJF", b"dfgjkedjfgkngfkjng", b"fgjsklfgjkdfjgk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKHJF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKHJF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKHJF>>(v1);
    }

    // decompiled from Move bytecode v6
}

