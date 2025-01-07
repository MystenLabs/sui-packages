module 0xe5de9058407a21abbce031aa84904cb514a073bd8b9c3aa4c9adbcf15e854951::suikey {
    struct SUIKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEY>(arg0, 6, b"SUIKEY", b"suimonkey", b"zzzzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Ta9c_J2_C_400x400_eb63a7e638.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

