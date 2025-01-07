module 0x6ce52312965233b0653f07ad0e3a0d4da7ee1f4de6b2611e9e985e3796eea939::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUII>(arg0, 6, b"Suii", b"Sui T-shirt", x"4e6f2070726f6d69736573200a4a75737420656e6a6f7920746865207375727072697365206c696b652074686520676f616c73206f662074686520446f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034902_f92cbc4881.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

