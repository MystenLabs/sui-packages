module 0x66d66b498bf8826fb3830dc349e47d307e67bd007f0a0471a8760a4096dd57ee::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFY", b"Captain GOOFy", x"416c72696768742c20796f752073616c74792073656120646f67732120200a0a4361707461696e20474f4f46792069732061626f757420746f20646f636b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_22_47_09_e412937fee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

