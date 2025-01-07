module 0xa365601890bd2399ada8bb78a22f886af7f58fb36a0af72ba92fe6a1e709ea5d::suitea {
    struct SUITEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEA>(arg0, 9, b"SUITEA", b"SuiTea", b"Sweet SuiTea time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1518531625239388160/0aSFGbGE.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITEA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

