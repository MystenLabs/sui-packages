module 0x1d06f5325d7ca5f4fc79a42acc6b3192349948fb15169292f01735415c402c30::chipo {
    struct CHIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPO>(arg0, 6, b"CHIPO", b"CHIPO", b"CHIPO pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTITExMLXUx6tZIukMivDZvJDuf9AC0zaW_gn4ShrdKw4J75XkEwdNfH_ToZjJVLdTV2EM&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHIPO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

