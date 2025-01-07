module 0x408170ba143b3226d7baaf8760c4804e0732de52e1be4bed116c0ac30e60054a::messiwater {
    struct MESSIWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSIWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESSIWATER>(arg0, 6, b"MessiWater", b"MessiWaterSui", b"God Messi! Go to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_09_22_47_41_fa838b0c7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESSIWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESSIWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

