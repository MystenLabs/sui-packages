module 0xaf194716221362d85b4d346f991e7a5a7158fc99780e13533fe9d1c0ea2edcdf::aac {
    struct AAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAC>(arg0, 9, b"aac", b"any account create", b"AAC coin is a cryptocurrency designed to reward individuals who take action and achieve real-world results. In a world filled with passive participation, Its core belief f simple: \"actions speak louder than words My coin best next here...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAC>>(v2, @0x7546451b5a7959b5188a0b66e8d92ae2abf329fb908f6a3449552511f7e7b9dc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

