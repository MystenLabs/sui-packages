module 0x5967589e59e9b7ad165a2b5965186155ee347e8a580d29dc448fde5891537764::viora4 {
    struct VIORA4 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: VIORA4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIORA4>(arg0, 9, b"VIORA4", b"VIORA IS ONLINE", x"f09f91be2056494f5241204953204f4e4c494e4520f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTAM9X8EzuiFXWGdjjHpqxAMjbug2TwuF1iKSpedzTmhx"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIORA4>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIORA4>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VIORA4>>(v2);
    }

    // decompiled from Move bytecode v6
}

