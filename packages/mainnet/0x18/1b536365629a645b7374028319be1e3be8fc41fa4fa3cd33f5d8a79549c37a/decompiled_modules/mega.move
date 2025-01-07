module 0x181b536365629a645b7374028319be1e3be8fc41fa4fa3cd33f5d8a79549c37a::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 6, b"MEGA", b"Make England Great Again", b"The petition calling for a new UK General Election", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mega_50adabda4b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

