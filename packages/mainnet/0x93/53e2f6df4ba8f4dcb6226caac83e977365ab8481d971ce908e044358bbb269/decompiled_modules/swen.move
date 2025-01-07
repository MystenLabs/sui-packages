module 0x9353e2f6df4ba8f4dcb6226caac83e977365ab8481d971ce908e044358bbb269::swen {
    struct SWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEN>(arg0, 6, b"sWEN", b"SUIWEN", b"The cutest cat on web3 is now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwen_ccad8fedae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

