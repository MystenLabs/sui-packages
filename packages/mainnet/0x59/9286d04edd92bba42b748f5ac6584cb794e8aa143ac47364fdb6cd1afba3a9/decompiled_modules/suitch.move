module 0x599286d04edd92bba42b748f5ac6584cb794e8aa143ac47364fdb6cd1afba3a9::suitch {
    struct SUITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCH>(arg0, 6, b"SUITCH", b"STITCH on SUI", x"535449544348204f4e20535549206f722053554954434820697320616e206578706572696d656e74203632362063726561746564206f6e207468652053554920636861696e0a535549544348202d207761732064657369676e656420746f20706f73736573732074686520776174657220636861696e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_titulo_1_1fa40b1abb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

