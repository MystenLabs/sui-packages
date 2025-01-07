module 0x318d6b5e5bdd8a85ba25d0b590e3baf2fbac5ffda2d70f526b9c25a98351a778::ronnie {
    struct RONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONNIE>(arg0, 6, b"RONNIE", b"Yeah Buddy", b"YEAHHHH BUDDYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_14_222535_3a40f55b1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

