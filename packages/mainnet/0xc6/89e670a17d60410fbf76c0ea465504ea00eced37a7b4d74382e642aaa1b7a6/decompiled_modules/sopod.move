module 0xc689e670a17d60410fbf76c0ea465504ea00eced37a7b4d74382e642aaa1b7a6::sopod {
    struct SOPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPOD>(arg0, 6, b"Sopod", b"Sopod AI", x"233120414920576174636820205765617220536f706f64204f5320687474703a2f2f736f706f642e61690a4149202b20446550494e3a2041204e657720457261206f66204175746f6e6f6d792e20506f77657265642062792074686520636f6d6d756e69747920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1wko_VFQI_400x400_278fc85010.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

