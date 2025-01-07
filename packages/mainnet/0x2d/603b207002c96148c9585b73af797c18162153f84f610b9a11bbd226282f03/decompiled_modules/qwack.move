module 0x2d603b207002c96148c9585b73af797c18162153f84f610b9a11bbd226282f03::qwack {
    struct QWACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWACK>(arg0, 6, b"QWACK", b"Qwack", b"QWACK QWACK QWACK...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QWACK_bb11975c54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QWACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

