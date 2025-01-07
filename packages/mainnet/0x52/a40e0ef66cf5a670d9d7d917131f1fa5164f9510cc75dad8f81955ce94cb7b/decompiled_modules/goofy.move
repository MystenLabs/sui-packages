module 0x52a40e0ef66cf5a670d9d7d917131f1fa5164f9510cc75dad8f81955ce94cb7b::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFy", b"Captain GOOFy", x"416c72696768742c20796f752073616c74792073656120646f67732120200a0a4361707461696e20474f4f46792068617320646f636b656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_16_22_24_48_b3f365fa0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

