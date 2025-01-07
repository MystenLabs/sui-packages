module 0x210fd355c043c0c81c6b5547558948af61822ee3230a94e53e29c80a911d297e::cide {
    struct CIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIDE>(arg0, 6, b"CIDE", b"SUICIDE", b"Did you blow all your wad on SOL scams MF! Good MF, Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wojak_suicide_f6c5ace653.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

