module 0x530d61fea9c338ef6c50dd0a24373f90b9b56639d4166633d56377260f3ba465::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"Trump", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmeh1sJkk3QhEAs9wxR25NgWYSjHnMi1HaZeR8dN7hERah")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

