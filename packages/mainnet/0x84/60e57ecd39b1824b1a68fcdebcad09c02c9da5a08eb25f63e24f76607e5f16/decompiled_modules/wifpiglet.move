module 0x8460e57ecd39b1824b1a68fcdebcad09c02c9da5a08eb25f63e24f76607e5f16::wifpiglet {
    struct WIFPIGLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFPIGLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFPIGLET>(arg0, 6, b"WifPiglet", b"Sui Wif Piglet", b"A woolen piglet is coming to the Sui forest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piglet_vmake_2_7c98796b34.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFPIGLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFPIGLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

