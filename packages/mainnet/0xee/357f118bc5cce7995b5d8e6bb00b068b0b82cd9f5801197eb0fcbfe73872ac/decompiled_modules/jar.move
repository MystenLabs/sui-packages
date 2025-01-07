module 0xee357f118bc5cce7995b5d8e6bb00b068b0b82cd9f5801197eb0fcbfe73872ac::jar {
    struct JAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAR>(arg0, 6, b"JAR", b"Jar", x"4a41522041492070726f746f636f6c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_B_Rh_F_Ef_C_400x400_d93a7aa009_d135330955.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

