module 0x4fa0945b78b3bc0bb7370698a6d19ccae6309dd23f054b06987733033707a75d::dago {
    struct DAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGO>(arg0, 6, b"DAGO", b"Dago Dog", b"Dago Dog; The paw-sitively fun memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022455_80488521c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

