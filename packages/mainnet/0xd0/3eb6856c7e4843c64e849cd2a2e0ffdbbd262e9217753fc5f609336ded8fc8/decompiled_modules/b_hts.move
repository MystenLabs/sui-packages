module 0xd03eb6856c7e4843c64e849cd2a2e0ffdbbd262e9217753fc5f609336ded8fc8::b_hts {
    struct B_HTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HTS>(arg0, 9, b"bHTS", b"bToken HTS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

