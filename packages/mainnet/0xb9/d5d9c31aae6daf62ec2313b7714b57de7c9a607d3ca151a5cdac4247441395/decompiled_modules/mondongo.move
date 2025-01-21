module 0xb9d5d9c31aae6daf62ec2313b7714b57de7c9a607d3ca151a5cdac4247441395::mondongo {
    struct MONDONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONDONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONDONGO>(arg0, 6, b"MONDONGO", b"$MONDONGO", b"Mondongo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mqdefault_1_2d3ebd70d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONDONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONDONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

