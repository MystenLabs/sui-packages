module 0xee3d10ab299cfe600f89902500ef45065d3513d4ef015d74c3ca219948d658aa::blsui {
    struct BLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLSUI>(arg0, 6, b"BLSUI", b"BlueShark", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images20_fa94e0c45a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

