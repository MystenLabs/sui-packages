module 0x866cf69e060d2ed41e3ea39f5426bcf6457b74a4e969767f55e0c5fa19031239::hippowater {
    struct HIPPOWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOWATER>(arg0, 9, b"HIPPOWATER", b"HIPPO WATER", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmsZAyusOKmAYZ1FL422A73RUcRP-Hc_V6Qg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPOWATER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOWATER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

