module 0xce560cefe7c7d4c83e28154fd9a17cd71428b027c9cccf74c36601bdbc69c94b::ouron {
    struct OURON has drop {
        dummy_field: bool,
    }

    fun init(arg0: OURON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OURON>(arg0, 6, b"OuRON", b"OuRON333", b"https://www.instagram.com/ouron_ai/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000736_bff262b760.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OURON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OURON>>(v1);
    }

    // decompiled from Move bytecode v6
}

