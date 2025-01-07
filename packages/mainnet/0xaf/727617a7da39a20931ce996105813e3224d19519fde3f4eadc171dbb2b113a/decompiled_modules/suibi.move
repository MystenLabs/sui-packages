module 0xaf727617a7da39a20931ce996105813e3224d19519fde3f4eadc171dbb2b113a::suibi {
    struct SUIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBI>(arg0, 6, b"SUIBI", b"Suibi Sui", x"4469766520696e746f20746865206465657020776174657273206f66202453554942492c20657665727920627562626c65206973206120676f6c6420636f696e206f6e20537569200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028556_89aa093927.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

