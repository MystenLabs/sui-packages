module 0x6942a9fe5c9ed32690107b9b983e05536fe46aeb0ad7d1ebb5cace827f4a9875::blud {
    struct BLUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUD>(arg0, 6, b"BLUD", b"Sui Blud", b"Meet BLUD, the coolest cat cruising the SUI network!  We're a fun-loving community of crypto enthusiasts ready to pounce on new adventures. Join our pack of playful felines as we chase the next big thing together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_10_12_T222912_883_84115bab49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

