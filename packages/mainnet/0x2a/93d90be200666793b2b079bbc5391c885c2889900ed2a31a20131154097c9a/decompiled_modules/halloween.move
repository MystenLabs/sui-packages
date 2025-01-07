module 0x2a93d90be200666793b2b079bbc5391c885c2889900ed2a31a20131154097c9a::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 9, b"HALLOWEEN", x"f09f8e8348414c4c4f5745454e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HALLOWEEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

