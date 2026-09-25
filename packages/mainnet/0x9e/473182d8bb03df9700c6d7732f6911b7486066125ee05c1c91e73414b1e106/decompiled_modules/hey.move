module 0x9e473182d8bb03df9700c6d7732f6911b7486066125ee05c1c91e73414b1e106::hey {
    struct HEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEY>(arg0, 9, b"HEY", b"HEY JEAN", b"Suck My ass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/ghdf0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

