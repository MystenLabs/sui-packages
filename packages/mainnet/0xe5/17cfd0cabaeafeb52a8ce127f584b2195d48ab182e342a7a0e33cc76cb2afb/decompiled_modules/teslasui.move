module 0xe517cfd0cabaeafeb52a8ce127f584b2195d48ab182e342a7a0e33cc76cb2afb::teslasui {
    struct TESLASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLASUI>(arg0, 9, b"TESLASUI", b"TESLA S", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESLASUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESLASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

