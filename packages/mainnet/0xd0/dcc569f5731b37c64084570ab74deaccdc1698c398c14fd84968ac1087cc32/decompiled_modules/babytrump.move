module 0xd0dcc569f5731b37c64084570ab74deaccdc1698c398c14fd84968ac1087cc32::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"Babytrump", b"babytrump", x"54686973206973207468652073746f7279206f662042616279205472756d702e205769746e657373206f7572206a6f75726e65792066726f6d206142616279206f72206d697373206f7574206f6e206f75722067726f7774682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730982317767.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

