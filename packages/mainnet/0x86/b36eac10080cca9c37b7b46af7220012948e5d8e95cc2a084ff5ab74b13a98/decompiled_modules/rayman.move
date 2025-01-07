module 0x86b36eac10080cca9c37b7b46af7220012948e5d8e95cc2a084ff5ab74b13a98::rayman {
    struct RAYMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAYMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYMAN>(arg0, 6, b"RAYMAN", b"Rayman: Chronicles of the Unknown", x"5261796d616e3a204368726f6e69636c6573206f662074686520556e6b6e6f776e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_a93691030f.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAYMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

