module 0x5cf36d7070a542048607b5d350e7c581f880d24209987f48b730ba51a73a22eb::drp {
    struct DRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRP>(arg0, 6, b"DRP", b"zkDRP", b"Ultra Mecha First VDrop Collection Sold out on Venomart. https://venomart.io/collection/0:0d992cf4fdf7a57f7338300456a0bbc3a1fda77a5c32217ffacd39de8308f080", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_18_16_38_02_695aba818d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

