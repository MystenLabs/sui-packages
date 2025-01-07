module 0x5568ed7b8004ff91ef78f3c04a9d4ac85468dd46b9892d4e4358e890c54c7f9a::petka {
    struct PETKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETKA>(arg0, 6, b"PETKA", b"Petka Microbe", b"@Petka_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2a_FQE_Hr_B_400x400_aac8473969.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

