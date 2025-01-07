module 0x8ed68052c491082189017b4a5b7152720656230597978ed6451f1d744e85cc47::miggles {
    struct MIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGGLES>(arg0, 6, b"MIGGLES", b"MR. Miggles", x"4d722e204d6967676c65732c205468652053554920436174204d6173636f740a2d206e6f7420616666696c6961746564207769746820535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ucing_8fa72e5c25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

