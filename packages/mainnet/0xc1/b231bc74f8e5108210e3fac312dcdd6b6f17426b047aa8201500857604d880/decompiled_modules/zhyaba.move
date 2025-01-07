module 0xc1b231bc74f8e5108210e3fac312dcdd6b6f17426b047aa8201500857604d880::zhyaba {
    struct ZHYABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHYABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHYABA>(arg0, 9, b"ZHYABA", b"Zhyaba", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/080/715/523/large/anna-kholomkina-my-zhaba2.jpg?1728334729")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZHYABA>(&mut v2, 500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHYABA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZHYABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

