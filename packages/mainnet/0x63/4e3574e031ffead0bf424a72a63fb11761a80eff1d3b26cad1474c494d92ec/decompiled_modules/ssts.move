module 0x634e3574e031ffead0bf424a72a63fb11761a80eff1d3b26cad1474c494d92ec::ssts {
    struct SSTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTS>(arg0, 6, b"SSTS", b"Sui Sea turtles", b"Sea turtles on Sui .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_07_47_2dc33075a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

