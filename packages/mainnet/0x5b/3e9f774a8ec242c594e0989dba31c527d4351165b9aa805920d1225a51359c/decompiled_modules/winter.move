module 0x5b3e9f774a8ec242c594e0989dba31c527d4351165b9aa805920d1225a51359c::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"Winter", b"Winter (dolphin) On Sui", b"Introducing Winter (dolphin) On Sui,after becoming entangled in a crab trap, Winter lost most of her tail due to severe injuries. This caused her to swim abnormally,he come to sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dolphin_49802fbded.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

