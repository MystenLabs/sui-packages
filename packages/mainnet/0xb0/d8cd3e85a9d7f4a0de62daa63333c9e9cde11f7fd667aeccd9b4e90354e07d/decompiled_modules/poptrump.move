module 0xb0d8cd3e85a9d7f4a0de62daa63333c9e9cde11f7fd667aeccd9b4e90354e07d::poptrump {
    struct POPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTRUMP>(arg0, 6, b"POPTRUMP", b"Pop Trump", b"Game coming, feed trump cats and dogs for points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_b21ul_L_Te_1728392148159_raw_9bb13bb1f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

