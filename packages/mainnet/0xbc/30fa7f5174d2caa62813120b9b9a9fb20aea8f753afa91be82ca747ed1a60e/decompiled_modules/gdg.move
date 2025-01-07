module 0xbc30fa7f5174d2caa62813120b9b9a9fb20aea8f753afa91be82ca747ed1a60e::gdg {
    struct GDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDG>(arg0, 6, b"GDG", b"GDog", b"Solana Dog community on sui. Everyone welcome!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0055_2b31920f5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

