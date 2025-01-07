module 0x6ca1c1a93289c38939c438ccae4712021c70394aebe624563de245b736e47b9a::ava {
    struct AVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVA>(arg0, 6, b"AVA", b"AVAsui", b"Ava, the golden big cat from Chiang Mai Night Safari.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_White_Bold_Playful_Kids_Clothing_Logo_1_11426bc340.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

