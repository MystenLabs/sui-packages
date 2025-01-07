module 0x43b72f9eedd12d133459bfee6e5b820771efff066148d9a0ad21bf5b50a4c8c1::beyed {
    struct BEYED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYED>(arg0, 6, b"BEYED", b"Blue eyed dragon", b"Blue eyed dragon, living legendary. Pumper of charts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Eyed_Dragon_Realistic_With_Black_Theme_40cc052742.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEYED>>(v1);
    }

    // decompiled from Move bytecode v6
}

