module 0x9bd1aa5eea5f1c67a9b4856e16b1585e24e28ea57f4d583f306788ef6b3e5de0::sujo {
    struct SUJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJO>(arg0, 6, b"Sujo", b"Sui Jojo", b"cutest dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUJO_5_d59ffb3f23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

