module 0xf11e6f7d3324879c209a7ece67c425ae3aaffc8f8fb6f38e02cdb557001e3fd2::suimorud {
    struct SUIMORUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMORUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMORUD>(arg0, 6, b"SUIMORUD", b"suimorud", b"If you are going to make it in this space, you have to know how to spot a good project and holdl so believe in MORUD! Mean time join the community on x:morud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MORUD_253cdaa4ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMORUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMORUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

