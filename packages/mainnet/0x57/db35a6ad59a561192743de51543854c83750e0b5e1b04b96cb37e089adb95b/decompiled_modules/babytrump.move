module 0x57db35a6ad59a561192743de51543854c83750e0b5e1b04b96cb37e089adb95b::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"BABYTRUMP", b"BABY TRUMP", x"42616279205472756d70206973206e6f74206f6e6c79206865726520746f2073746179202d206974277320686572650a746f20646f6d696e617465202353554920616e642074616b65206f7665722074686520656e746972650a2363727970746f7370616365210a0a4a6f696e20746865204d6f76656d656e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_22_35_47_3612fd13cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

