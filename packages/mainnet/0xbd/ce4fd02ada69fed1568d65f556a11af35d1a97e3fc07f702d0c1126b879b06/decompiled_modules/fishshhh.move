module 0xbdce4fd02ada69fed1568d65f556a11af35d1a97e3fc07f702d0c1126b879b06::fishshhh {
    struct FISHSHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHSHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHSHHH>(arg0, 6, b"FISHSHHH", b"Fish Shhh", b"Shhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_2_e814028b93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHSHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHSHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

