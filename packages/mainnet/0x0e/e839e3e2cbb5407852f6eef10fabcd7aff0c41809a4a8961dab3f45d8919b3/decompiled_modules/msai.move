module 0xee839e3e2cbb5407852f6eef10fabcd7aff0c41809a4a8961dab3f45d8919b3::msai {
    struct MSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSAI>(arg0, 6, b"MSAI", b"MetaSuiAi", x"4149204167656e74732c47616d696e672c204e465473200a20544845204d4153434f54204f462054484520414456454e5455524553204f46204c4f52452e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018218_e057882e1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

