module 0xbaff230bccbcf914e6395a9157384ac0b821447763b6357bf25b9d65d2dbfda5::skid {
    struct SKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKID>(arg0, 6, b"SKID", b"SUICESS KID", b"We will be SUICESSFUL!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5782_0dfb57c94f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKID>>(v1);
    }

    // decompiled from Move bytecode v6
}

