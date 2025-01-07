module 0x9fb6fd7b56bd2fefb3672a1a3d1383384d5dbdba2e0fabc89510c48e61d38ce6::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"Suisseball", x"54686520696e66616d6f75732043686565736562616c6c2077697a617264206361742066726f6d20737769747a65726c616e64206e6f77206f6e20535549200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suisseball_9a074f3163.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

