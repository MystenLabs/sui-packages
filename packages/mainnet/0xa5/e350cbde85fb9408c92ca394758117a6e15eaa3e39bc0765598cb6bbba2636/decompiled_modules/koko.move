module 0xa5e350cbde85fb9408c92ca394758117a6e15eaa3e39bc0765598cb6bbba2636::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 6, b"KOKO", b"KOALA", x"48692c20496d20244b4f4b4f210a50656f706c652074656c6c206d652049206c6f6f6b206c696b6520504550452e0a492074656c6c207468656d2c2049276d2061204b4f414c4121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ap0_BSF_Ac_400x400_86531a5fc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

