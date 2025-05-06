module 0x10d1850dcf4c346d74db0cb7c0c145d420d9dbd7508289e1090ddaf8f585cdc7::aporeon {
    struct APOREON has drop {
        dummy_field: bool,
    }

    fun init(arg0: APOREON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APOREON>(arg0, 6, b"APOREON", b"ANALPOREON", b"Iroh and Exhaust got in your ass, come here i won't rug or make any excuse about supply control, just enjoy the massage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietfchxxfxlgez47ubne5rr534e2vjz3dbosp5y72kieakzesg7y4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APOREON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APOREON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

