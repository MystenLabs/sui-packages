module 0xa73e666380a73419da548e36afa6706e2a330d8b4107aad413d07f0b1b055997::ea {
    struct EA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EA>(arg0, 6, b"EA", b"Enjoy Apu Cat", b"Bringing a little sweetness to your world, every day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_391da85677.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EA>>(v1);
    }

    // decompiled from Move bytecode v6
}

