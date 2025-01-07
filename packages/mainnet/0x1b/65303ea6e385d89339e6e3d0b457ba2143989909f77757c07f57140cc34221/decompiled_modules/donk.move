module 0x1b65303ea6e385d89339e6e3d0b457ba2143989909f77757c07f57140cc34221::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 6, b"DONK", b"DONK!", b"IM THE FIRST ZEBRA COIN, FOR THE PEOPLE, BY THE PEOPLE @ Donkmove.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_120440_b6b43ddbec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

