module 0x5fc477e9f484912cdede2becaf502a4e5a84ff8559b75ab65a793cfd9c002064::scamoshi {
    struct SCAMOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAMOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAMOSHI>(arg0, 9, b"SCAMOSHI", b"SCAMOMOTO", b"SKAMOSHI SCAMOMOTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn-imfij.nitrocdn.com/HUHnSkzifeFTtpIjAxHljghCQiIIhrdU/assets/images/optimized/rev-1036937/ecoinomy.eu/wp-content/uploads/2023/02/bitcoin_creator_satoshi_nakamoto_v01.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAMOSHI>(&mut v2, 33333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAMOSHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAMOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

