module 0x28df5126890ca253ad66c471ef58f03198c4726bb9ce9daa4d166c40f499debb::chud {
    struct CHUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUD>(arg0, 6, b"CHUD", b"CHUD SUI", b"just a lil chud in a big sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_29_05_10_17_9d36cdcbea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

