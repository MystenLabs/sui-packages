module 0x439dc5b02f643131f94cfbfeb577bba3c02ff23b4e5158bad436f79293a37685::snwy {
    struct SNWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNWY>(arg0, 6, b"SNWY", b"SNOWY", b"The lovable $SNOWY will give Dope Art to Loyal Holder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logolaunchfix_069e996f07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

