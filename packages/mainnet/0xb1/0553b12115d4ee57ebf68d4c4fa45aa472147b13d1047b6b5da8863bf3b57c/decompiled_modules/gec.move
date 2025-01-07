module 0xb10553b12115d4ee57ebf68d4c4fa45aa472147b13d1047b6b5da8863bf3b57c::gec {
    struct GEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEC>(arg0, 6, b"GEC", b"Gecko Inu", x"57652061726520746865206d6f737420667269656e646c79206c697a617264206f6e205355492120466f756e6465642062792077656c6c2d726573706563746564206d656d62657273207769746820612068696768205355492063756c747572652e20474543206973206120636f6d6d756e6974792d64726976656e2070726f6a65637420616e642077696c6c206265206f6e6c7920666f722074686520636f6d6d756e6974792e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Nxab_Iqd_400x400_337d1789be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

