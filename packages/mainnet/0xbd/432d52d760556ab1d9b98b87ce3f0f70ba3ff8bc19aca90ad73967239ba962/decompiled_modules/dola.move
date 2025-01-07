module 0xbd432d52d760556ab1d9b98b87ce3f0f70ba3ff8bc19aca90ad73967239ba962::dola {
    struct DOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLA>(arg0, 6, b"Dola", b"Dolphin Agent", x"57454c434f4d4520544f20444f4c5048494e204147454e54210a594f555220534f4e415220494e2054484520535549204f4345414e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M40_W4al_A_400x400_33a1931ac8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

