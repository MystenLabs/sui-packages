module 0x8de3efc0bd637b82502a45cf4fc700c4f870410f5d318ca000672c0023ab7e42::stams {
    struct STAMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMS>(arg0, 6, b"STAMS", b"Star", b"A Starr from living at sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20241007223719_3dad213a18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

