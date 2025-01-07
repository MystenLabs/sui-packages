module 0xa17330b23091292e6c211098174a2015fc27e164b5932b75552755ed5fd51eea::spielbergai {
    struct SPIELBERGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIELBERGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIELBERGAI>(arg0, 6, b"SpielbergAI", b"Spielberg AI", b"welcome to the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1229_6_a3b4a8e69c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIELBERGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIELBERGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

