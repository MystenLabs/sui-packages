module 0xbcc72ee8ec054285205c3d71d393652646d3e6f7bccccf69704edf57ef74c5a0::ponchita {
    struct PONCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONCHITA>(arg0, 9, b"PONCHITA", b"Baby Ponchita", b"Baby Ponchita 1M$ token pump to the moon comming diamond hand", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONCHITA>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONCHITA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

