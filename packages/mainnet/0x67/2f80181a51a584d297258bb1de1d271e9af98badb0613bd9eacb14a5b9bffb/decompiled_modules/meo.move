module 0x672f80181a51a584d297258bb1de1d271e9af98badb0613bd9eacb14a5b9bffb::meo {
    struct MEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEO>(arg0, 9, b"NKC", b"Nikka", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.ipfs.io")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEO>(&mut v2, 30000000 * 0x2::math::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

