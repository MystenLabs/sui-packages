module 0x40c22fb1e840254680338e354e5413464d5203a9b081c5f39914ea64eb7ecf9b::dpd {
    struct DPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPD>(arg0, 9, b"DPD", b"DolphinDollars", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcR17Abi4pkuOn420ML2bEH8xc_Y7nv6z4V3hLE05j7jhe4AcJPB0tomqhjsgaPN5aOjU&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DPD>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

