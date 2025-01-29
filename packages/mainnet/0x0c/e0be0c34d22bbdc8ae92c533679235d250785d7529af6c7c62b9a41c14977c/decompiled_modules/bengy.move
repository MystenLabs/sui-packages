module 0xce0be0c34d22bbdc8ae92c533679235d250785d7529af6c7c62b9a41c14977c::bengy {
    struct BENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENGY>(arg0, 6, b"BENGY", b"BENGY ON SUI", x"48492c20494d202442454e4759210a0a50454f504c452054454c4c204d452049204c4f4f4b204c494b4520504550452e20492054454c4c205448454d20494d20412050454e4755494e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_160756_973_c44ea91294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

