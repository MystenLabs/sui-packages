module 0x3a30d6e274119f2ec46ebb7a83984de43e05140f2ceaf8df3362fabf1fb392d::duki {
    struct DUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKI>(arg0, 6, b"DUKI", b"Duki Duck", b"Welcome to the wild spirit of Duki, a fearless yellow degen duck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004426026.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

