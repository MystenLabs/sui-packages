module 0x4eba09dc6ae64eb6c57edc5999642cb4981d09f8f0fde067888c053c0aecb858::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 9, b"Neiro", b"Neiro", b"The little sister of Doge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1820563656565776386/gpVFRZjO_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

