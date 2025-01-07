module 0x2bf2703b9791fa5bb8b86704403c37dbe223897e710d9373e960959bc3f2aa60::airsuishiba {
    struct AIRSUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRSUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1652612936764997633/fHY1LNIz_400x400.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<AIRSUISHIBA>(arg0, 6, b"airSuiShib", b"airSuiShiba", b"#SuiShiba is a community-driven meme project. Built by a team of believers, Suishiba is ready to take on any challenge and have some fun along the way!", v0, arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<AIRSUISHIBA>(&mut v3, 30000000000000000, @0x3a4b8f7cd8a01881ce236d07c43e1460f6807d28c561f6eab41ebdcbcc9bfc95, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIRSUISHIBA>>(v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRSUISHIBA>>(v2);
    }

    // decompiled from Move bytecode v6
}

