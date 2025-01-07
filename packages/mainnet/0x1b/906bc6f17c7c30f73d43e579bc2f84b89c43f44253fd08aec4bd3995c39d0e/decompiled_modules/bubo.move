module 0x1b906bc6f17c7c30f73d43e579bc2f84b89c43f44253fd08aec4bd3995c39d0e::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"Bubo", b"BuboSui", x"4275626f206973206d756368206d6f7265207468616e206120746f6b656e2c20697427732061207068696c6f736f706879206f66206c6966652c2061207374617465206f66206d696e642e20244275626f206973206865726520746f207374617920616e6420746f206d616b6520686973746f72792e0a4661646520617420796f7572206f776e207269736b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S5_UO_Jd_I_400x400_f2a13d7d00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

