module 0x6f8eb0deb785a4aca7ed87ff99d53481ebd1996f42610ad21a1231624b2b52b9::pepe_sui {
    struct PEPE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_SUI>(arg0, 9, b"PEPE SUI", x"f09f90b85065706520535549", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIP.IFj_OoMQXwqYSO-nscSUiQHaG_?w=182&h=180&c=7&r=0&o=5&pid=1.7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPE_SUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

