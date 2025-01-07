module 0xd08de97240da8c5671b64ce0293e8b6e372c88c69ae1d1aabc9b2607cd98fe::lmn {
    struct LMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMN>(arg0, 8, b"LMN", b"LEMON", b"a simple lemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSumKMHyRghVlFwcXSPHG_ORWhlkp8zk5g1Aw&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LMN>(&mut v2, 80000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

