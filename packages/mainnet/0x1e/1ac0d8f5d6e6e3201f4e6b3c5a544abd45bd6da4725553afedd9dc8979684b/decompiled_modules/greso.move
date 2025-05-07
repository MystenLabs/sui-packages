module 0x1e1ac0d8f5d6e6e3201f4e6b3c5a544abd45bd6da4725553afedd9dc8979684b::greso {
    struct GRESO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRESO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRESO>(arg0, 6, b"GRESO", b"Greso On Sui", b"No utility - just $Greso", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250508_025410_80fa44ed52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRESO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRESO>>(v1);
    }

    // decompiled from Move bytecode v6
}

