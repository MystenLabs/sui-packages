module 0x4fbe8c39b516c0d912f93c8e360e2570c22e51d0ad490ff86ea64e413b7e11da::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPS>(arg0, 6, b"PEPS", b"Pepsuiii", b"First Pepe mme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062515_f64508060e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

