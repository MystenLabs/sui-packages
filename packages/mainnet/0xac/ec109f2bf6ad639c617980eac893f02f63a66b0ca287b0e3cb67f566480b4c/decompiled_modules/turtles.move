module 0xacec109f2bf6ad639c617980eac893f02f63a66b0ca287b0e3cb67f566480b4c::turtles {
    struct TURTLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLES>(arg0, 6, b"Turtles", b"SUI Turtles", b"What will this turtle do if it appears in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/260763746_0_final_6a0cb47fa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

