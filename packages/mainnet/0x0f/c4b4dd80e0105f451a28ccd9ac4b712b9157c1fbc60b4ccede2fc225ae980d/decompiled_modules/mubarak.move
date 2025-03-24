module 0xfc4b4dd80e0105f451a28ccd9ac4b712b9157c1fbc60b4ccede2fc225ae980d::mubarak {
    struct MUBARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUBARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUBARAK>(arg0, 6, b"MUBARAK", b"Mubarak", x"4d75626172616b202d20436f6d6d756e6974792074616b65206f7665720a424e4220436861696e20477265617420416761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Kjv3dc6_400x400_Photoroom_e8b6f4d374.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUBARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUBARAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

