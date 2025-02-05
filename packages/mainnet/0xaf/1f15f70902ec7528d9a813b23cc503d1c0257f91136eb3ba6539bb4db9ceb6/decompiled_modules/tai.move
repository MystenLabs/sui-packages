module 0xaf1f15f70902ec7528d9a813b23cc503d1c0257f91136eb3ba6539bb4db9ceb6::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAI>(arg0, 6, b"TAI", b"technicalai by SuiAI", b"This project specializes in technical analysis and brings benefits to its participants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/S_102080570_108a65c9ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

