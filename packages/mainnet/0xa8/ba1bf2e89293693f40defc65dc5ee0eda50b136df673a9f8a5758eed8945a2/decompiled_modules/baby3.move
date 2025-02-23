module 0xa8ba1bf2e89293693f40defc65dc5ee0eda50b136df673a9f8a5758eed8945a2::baby3 {
    struct BABY3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY3>(arg0, 6, b"Baby3", b"BabyThree", b"Baby Three is a Chinese stuffed toy, first released in May in the form of a \"blind box\". Each dish is designed in its own style, inspired by animals. Players can collect many collections such as Macaron, Lucky Cat, V1 Toy Party Series, Baby Three V3, 12 zo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/dd184194-e5ef-46e6-aba8-685a63b15f13.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABY3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

