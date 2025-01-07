module 0x30544732eb1dd1aa2c14198e30b6831acc9cda9548a76247785af6fdb249ff44::onlyup {
    struct ONLYUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYUP>(arg0, 6, b"ONLYUP", b"OnlyUP", b"OnlyUP ($UP) is more than just a meme token; its a movement. With a unique tokenomics structure, OnlyUP ensures continuous growth and community engagement while making a real-world impact.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727020614823_11cb191470cb3bac62eda435d9c486da_a75fdecb3d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

