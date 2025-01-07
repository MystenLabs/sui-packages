module 0xcebc57d5e8ff7c6f114d66bdab3db27b8593b405afab5699dcb998db97de3da6::sgen {
    struct SGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGEN>(arg0, 6, b"SGEN", b"Suigen", b"Future millionaires in progress!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_504x498_pad_600x600_f8f8f8_ed00528b34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

