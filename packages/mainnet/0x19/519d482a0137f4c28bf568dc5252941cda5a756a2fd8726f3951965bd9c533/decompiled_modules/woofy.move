module 0x19519d482a0137f4c28bf568dc5252941cda5a756a2fd8726f3951965bd9c533::woofy {
    struct WOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFY>(arg0, 9, b"WOOFY", b"TheWolfOfSuistreet", b"Plain and simple WOOFY,is the next most successful meme on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1800843509554941952/iOKDgaqb.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOOFY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

