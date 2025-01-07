module 0x84811846fb28023751aac837ae86cc699a0639b4983c71d953f3a9bdbf31f722::redbox {
    struct REDBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDBOX>(arg0, 6, b"REDBOX", b"RED BOX ON SUI", b"REDBOX for comunity on SUI, dev will burn supply at bonding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_31_14_42_38_c41f56e52d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

