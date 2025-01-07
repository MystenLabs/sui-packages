module 0xe80df4dd2af15c00df7c36840a5aea6d0cfe25368d1c1f9b420fc95d9725b183::bnnk {
    struct BNNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNNK>(arg0, 6, b"BNNK", b"Banana Monkey", b"BNNK On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BNNA_20ada518df.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

