module 0xfcdbda0aea99fcc4f8f94b754be58a404b0bd9fbb6044ae875fab34949d507b7::dat69ape {
    struct DAT69APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAT69APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAT69APE>(arg0, 6, b"DAT69APE", b"DAT69APE SUI", b"DAT69APE sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_3_50de33f52b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAT69APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAT69APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

