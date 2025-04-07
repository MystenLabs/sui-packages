module 0xb1230f16aa08beb48a00410375802fed5a4a4d1234956f4bb82a8ba2305e18c6::iiwii {
    struct IIWII has drop {
        dummy_field: bool,
    }

    fun init(arg0: IIWII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IIWII>(arg0, 6, b"IIWII", b"It Is What It Is", b"Embrace the absurdity. The worlds on fire, and were vibing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055145_c50fe1d535.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IIWII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IIWII>>(v1);
    }

    // decompiled from Move bytecode v6
}

