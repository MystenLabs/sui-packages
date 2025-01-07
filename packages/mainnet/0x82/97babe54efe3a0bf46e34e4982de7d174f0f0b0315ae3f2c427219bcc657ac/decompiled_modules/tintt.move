module 0x8297babe54efe3a0bf46e34e4982de7d174f0f0b0315ae3f2c427219bcc657ac::tintt {
    struct TINTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINTT>(arg0, 9, b"TINTT", b"TINTT", b"T and T", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkiPZX7sHRjB8655icQZ-6YD-KpJD5aP0eNw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TINTT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

