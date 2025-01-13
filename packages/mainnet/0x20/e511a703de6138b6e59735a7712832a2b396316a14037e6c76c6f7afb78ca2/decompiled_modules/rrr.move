module 0x20e511a703de6138b6e59735a7712832a2b396316a14037e6c76c6f7afb78ca2::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 9, b"rrr", b"rrr", b"rrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreic5rvww44r365h66omnrhxft5fsz7v4cliq45xbiv4d4g7isbl7sm?X-Algorithm=PINATA1&X-Date=1736742425&X-Expires=315360000&X-Method=GET&X-Signature=7d0544e38b1e4e211e6ca1e88aa237f56ad92ae14c7601a2506de03a7eda0bf3"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RRR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RRR>>(v2);
    }

    // decompiled from Move bytecode v6
}

