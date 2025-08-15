module 0xcdf759522e535c919cc4299df6ad0f1204ae563a2e33c9a6fae7d49d56d3fbe0::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"VHH", b"TightToken", b"TightToken for learn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5148959844.2540/st,small,507x507-pad,600x600,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

