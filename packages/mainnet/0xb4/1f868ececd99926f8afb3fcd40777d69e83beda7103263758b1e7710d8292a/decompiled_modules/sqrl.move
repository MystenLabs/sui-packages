module 0xb41f868ececd99926f8afb3fcd40777d69e83beda7103263758b1e7710d8292a::sqrl {
    struct SQRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQRL>(arg0, 6, b"SQRL", b"Suirrel", b"They said i couldn't do it, but look at me now - making waves as the face of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/139_B00_ED_DC_76_4131_B69_B_4_B751_FC_1_F311_826cb774dd.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

