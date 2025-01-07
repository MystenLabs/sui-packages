module 0xe87e88f9a946ff4f317a47bc962ca2489bdeb61543cfbd89a9ba1f6d29ed6af4::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"Suigar", b"$Suigar", b"Play and earn $Sui on-chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pot_Ic4l_U_400x400_8df5d55ff5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

