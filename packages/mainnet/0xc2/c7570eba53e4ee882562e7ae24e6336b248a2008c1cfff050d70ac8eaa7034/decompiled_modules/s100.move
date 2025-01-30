module 0xc2c7570eba53e4ee882562e7ae24e6336b248a2008c1cfff050d70ac8eaa7034::s100 {
    struct S100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S100, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S100>(arg0, 6, b"S100", b"Sui100", b" First AI X agent on sui powered by DeepSeek-R1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_Muo4_A0_X_400x400_ff7652af21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S100>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S100>>(v1);
    }

    // decompiled from Move bytecode v6
}

