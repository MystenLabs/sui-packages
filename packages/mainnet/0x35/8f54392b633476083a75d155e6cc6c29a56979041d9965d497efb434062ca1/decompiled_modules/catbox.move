module 0x358f54392b633476083a75d155e6cc6c29a56979041d9965d497efb434062ca1::catbox {
    struct CATBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOX>(arg0, 6, b"CATBOX", b"Cat Wif Box", b"Cat wif Box ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_16_06_18_c779ebddb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

