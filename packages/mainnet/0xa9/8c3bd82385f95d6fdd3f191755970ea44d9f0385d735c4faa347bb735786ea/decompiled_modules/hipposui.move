module 0xa98c3bd82385f95d6fdd3f191755970ea44d9f0385d735c4faa347bb735786ea::hipposui {
    struct HIPPOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOSUI>(arg0, 9, b"HIPPOSUI", b"HIPPO SUI", b"Official token of Hippo Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPOSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

