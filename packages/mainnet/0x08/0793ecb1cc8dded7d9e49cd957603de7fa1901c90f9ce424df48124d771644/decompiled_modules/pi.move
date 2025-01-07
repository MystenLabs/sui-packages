module 0x80793ecb1cc8dded7d9e49cd957603de7fa1901c90f9ce424df48124d771644::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 9, b"PI", b"Pi coin", b"The price of Pi Network (PI) is $42.36 today with a 24-hour trading volume of $395,179. This represent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21dc9760-f85c-4a42-b3f3-55c8072119be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

