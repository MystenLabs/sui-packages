module 0xcf6e838095b04542194b41e0fffe6e6d5e32ae7c87681970dbda19a122f42b9b::laonsui {
    struct LAONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAONSUI>(arg0, 6, b"LAONSUI", b"LOS ANGELES FIRE", b"WELCOME TO LA ON SUI, HOPE LA WILL GET BETTER SOON!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LA_ON_FIRE_8b1277b1e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

