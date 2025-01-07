module 0xa03f61a95f4ed4c5f47a30bb4a2df78146a0f9adcaf900d39e8a77bc395afd40::bhippo {
    struct BHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHIPPO>(arg0, 9, b"BHIPPO", b"BHIPPO", b"BHIPPO baby HIPPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/storage/emulated/0/Download/images.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BHIPPO>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHIPPO>>(v2, @0x786feadf119e29f84ec5237215d2bfd291a57e438a75f6fc73f344f52f10270);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

