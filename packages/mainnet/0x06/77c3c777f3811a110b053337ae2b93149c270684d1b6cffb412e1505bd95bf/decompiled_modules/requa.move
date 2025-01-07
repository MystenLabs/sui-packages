module 0x677c3c777f3811a110b053337ae2b93149c270684d1b6cffb412e1505bd95bf::requa {
    struct REQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REQUA>(arg0, 9, b"REQUA", b"Requa", b"Religious girl - Requa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/users/5638/screenshots/7156724/image.png?resize=800x600&vertical=center")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REQUA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REQUA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

