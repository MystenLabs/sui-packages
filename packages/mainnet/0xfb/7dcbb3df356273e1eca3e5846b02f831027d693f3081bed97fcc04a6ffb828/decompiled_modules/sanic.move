module 0xfb7dcbb3df356273e1eca3e5846b02f831027d693f3081bed97fcc04a6ffb828::sanic {
    struct SANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIC>(arg0, 6, b"SANIC", b"Sanic on Sol", x"43757272656e746c79206f6e205355492c20736f6f6e206f6e2024530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_1_ZM_Asa0_A_Aj_DSK_1a06c44d34.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

