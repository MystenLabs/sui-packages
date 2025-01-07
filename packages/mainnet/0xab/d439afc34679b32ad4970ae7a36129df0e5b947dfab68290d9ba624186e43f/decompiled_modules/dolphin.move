module 0xabd439afc34679b32ad4970ae7a36129df0e5b947dfab68290d9ba624186e43f::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 0, b"DOLPHIN", b"DOLPHIN ON SUI", b"World's cutest meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/s6c1tgB")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLPHIN>(&mut v2, 9000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

