module 0xbf3776307971bbfdd4a428ee80e3ce0a4ed3c5b5761ca06d23869abe9d143051::posui {
    struct POSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSUI>(arg0, 6, b"POSUI", b"Poseidon AI \"God of the SUI\"", x"506f736569646f6e2022476f64206f662074686520536561222041492072756c65732024535549207761746572730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ky4_AZ_0h_400x400_75a9b936b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

