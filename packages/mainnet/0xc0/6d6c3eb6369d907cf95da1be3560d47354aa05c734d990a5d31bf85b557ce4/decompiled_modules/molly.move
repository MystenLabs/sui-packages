module 0xc06d6c3eb6369d907cf95da1be3560d47354aa05c734d990a5d31bf85b557ce4::molly {
    struct MOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLLY>(arg0, 9, b"MOLLY", b"Molly The Cats", b"Molly The Cats on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCrUgGy-T3NGoflSMhlYkE3M9p1D4CJkKdaA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOLLY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

