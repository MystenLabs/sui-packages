module 0x5dfd34938317f9e8dd72dca704ec364b9796a047382a8f997990a46c23087394::zkai {
    struct ZKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZKAI>(arg0, 6, b"ZKAI", b"ZKCrypt AI", x"546865204149204669726577616c6c3a2054686520556c74696d617465205072697661637920536869656c6420416761696e737420414920496e74727573696f6e730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5959e94661e1203e0c8ef84095a7846bacc6a94f_1_4743cc27d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

