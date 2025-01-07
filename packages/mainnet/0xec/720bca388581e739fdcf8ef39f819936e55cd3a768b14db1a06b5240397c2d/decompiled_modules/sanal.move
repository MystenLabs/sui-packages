module 0xec720bca388581e739fdcf8ef39f819936e55cd3a768b14db1a06b5240397c2d::sanal {
    struct SANAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANAL>(arg0, 6, b"SANAL", b"Solanaus", b"Retar...Typical alien from solana blockhai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/alien_cult_1_3595c233fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

