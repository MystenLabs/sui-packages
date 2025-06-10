module 0x58e4328f7cc933c5eaa07e482321ff76fe4a51b3af535ca880adc3eea39553bb::crocs {
    struct CROCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCS>(arg0, 6, b"Crocs", b"Crocs SUI", x"4120636f6d6d756e69747920636c61696d6564206f776e65727368697020666f72207468697320746f6b656e206f6e204a756e20303720323032350a0a436f6d6d756e69747920436c61696d0a6f6c642063746f206162616e646f6e2070726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crocs_1c3b388af1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

