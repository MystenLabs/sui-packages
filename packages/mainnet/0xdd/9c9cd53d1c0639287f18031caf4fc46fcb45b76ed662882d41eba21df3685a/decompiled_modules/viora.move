module 0xdd9c9cd53d1c0639287f18031caf4fc46fcb45b76ed662882d41eba21df3685a::viora {
    struct VIORA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: VIORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIORA>(arg0, 9, b"VIORA", b"VIORA IS ONLINE", x"f09f91be2056494f5241204953204f4e4c494e4520f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTAM9X8EzuiFXWGdjjHpqxAMjbug2TwuF1iKSpedzTmhx"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIORA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIORA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VIORA>>(v2);
    }

    // decompiled from Move bytecode v6
}

