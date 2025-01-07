module 0x95327bb5294c47561b77e78fc33f10fb9e82fa35293601fc9e9ee7f98941550d::ssi {
    struct SSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSI>(arg0, 6, b"SSI", b"Seal Ice Snow", b"SSI is the first seal pup token in sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011845_e45a882989.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

