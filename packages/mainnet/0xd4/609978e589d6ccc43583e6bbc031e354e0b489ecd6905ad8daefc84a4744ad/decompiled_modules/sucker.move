module 0xd4609978e589d6ccc43583e6bbc031e354e0b489ecd6905ad8daefc84a4744ad::sucker {
    struct SUCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCKER>(arg0, 6, b"SUCKER", b"Sucker", b"The Sucker of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003211_05c4f5bac3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

