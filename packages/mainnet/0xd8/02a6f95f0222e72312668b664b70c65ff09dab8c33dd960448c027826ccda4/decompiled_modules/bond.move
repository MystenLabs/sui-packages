module 0xd802a6f95f0222e72312668b664b70c65ff09dab8c33dd960448c027826ccda4::bond {
    struct BOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOND>(arg0, 6, b"Bond", b"Bond Villain", b"Hi, my name is Bond. The cat has one foggy eye. Add a bow tie and he instantly becomes a James Bond Villains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/James_c8ab9f2a9f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

