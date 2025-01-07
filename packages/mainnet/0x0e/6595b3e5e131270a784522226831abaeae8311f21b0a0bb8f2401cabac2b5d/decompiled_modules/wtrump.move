module 0xe6595b3e5e131270a784522226831abaeae8311f21b0a0bb8f2401cabac2b5d::wtrump {
    struct WTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTRUMP>(arg0, 6, b"wTRUMP", b"TRUMP on SUI", b"Americas wTRUMP coming to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Q6n_Gn8r_400x400_7b40070d21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

