module 0x2aa3bd1624b071363d3bba8e8b4f462b6f54447cbd0c1774a6da5b7b0c66e369::charmy {
    struct CHARMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMY>(arg0, 6, b"Charmy", b"CharmyShiba", b"A wonderful girl shiba that loves fluffy things and massages from its furparent. Healing its inner peace by relaxing on her vacations is a dream from 9 year old Shiba girl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_18_51_01_38f0a56c58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

