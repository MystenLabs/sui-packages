module 0x739103b56a96fbf68767275c716a5f7b8f46fa6e0464b553f98d925790322a44::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 9, b"SUIMAN", b"SuiperMan", b"Suiperman is a cutting-edge cryptocurrency launched on Sui Chain, a high-performance blockchain known for its speed and scalability. Suiperman leverages Sui Chain's advanced technology to deliver secure, lightning-fast transactions, low fees, and decentralized governance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/R4SWBCC/SUICHAIN.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

