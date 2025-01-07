module 0x17aa74e23b282c14ee761d2cb648b0129c1cf9c916cd3a62889afcbad71e525e::jesuis {
    struct JESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIS>(arg0, 9, b"JESUIS", b"JESUIS", b"Official token of JESUIS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JESUIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

