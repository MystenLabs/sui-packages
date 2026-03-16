module 0xb87a7e533a09dd96d0fd25faae40d64b776773d2a47705f9df0616e72d052ab3::bublz {
    struct BUBLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLZ>(arg0, 9, b"BUBLZ", b"Bublz", x"4255424c5a206973206120726963682065636f73797374656d206f6620746f6f6c7320616e64207574696c6974696573206275696c74206e61746976656c79206f6e205375692e2044657369676e656420666f7220747261646572732c206275696c646572732c20616e642074686520636f6d6d756e69747920e280942065766572797468696e6720796f75206e65656420746f206e6176696761746520746865205375692065636f73797374656d2c20616c6c20696e206f6e6520706c6163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://rodenxzjyezaxzdjqnee.supabase.co/storage/v1/object/public/assets/bublzlogo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BUBLZ>>(0x2::coin::mint<BUBLZ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLZ>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

