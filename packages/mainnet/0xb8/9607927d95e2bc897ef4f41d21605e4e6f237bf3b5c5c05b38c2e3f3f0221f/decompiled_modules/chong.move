module 0xb89607927d95e2bc897ef4f41d21605e4e6f237bf3b5c5c05b38c2e3f3f0221f::chong {
    struct CHONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONG>(arg0, 6, b"CHONG", b"evun chong", b"$chong is da prez of SUI. Evan Cheng is super smart, mek blockchains. Evun Chong is supa dum, mek memes and lead da wata blokchen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/evon1_4354248ef6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

