module 0x6aae55e31285e445010fbb638a3ef2b5740ead1ac9812e9902d5100bb3e9f9f3::doti {
    struct DOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTI>(arg0, 9, b"DOTI", b"DotSui", b" test sheet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1646097055079886850/vlr-KKB8_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOTI>(&mut v2, 1111111111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

