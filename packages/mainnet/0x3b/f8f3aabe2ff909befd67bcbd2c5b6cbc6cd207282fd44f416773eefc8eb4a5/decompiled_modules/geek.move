module 0x3bf8f3aabe2ff909befd67bcbd2c5b6cbc6cd207282fd44f416773eefc8eb4a5::geek {
    struct GEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEEK>(arg0, 6, b"GEEK", b"Geek Sui", x"244745454b204953204120434f494e2057495448204e4f0a5245414c2056414c55452e20244745454b205345525645530a4e4f20505552504f5345204f54484552205448414e0a454e5445525441494e4d454e542e20244745454b0a444f45534e2754204841564520414e592056414c554520414e440a50454f504c452057484f204255592049540a53484f554c444e27542045585045435420414e590a46494e414e4349414c2052455455524e532e205748454e0a50555243484153494e4720534345454b20594f55204152450a4147524545494e47205448415420594f5520484156450a5345454e205448495320444953434c41494d4552", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069295_8a8bb9dacb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

