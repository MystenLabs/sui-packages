module 0x863fc1224e5398591e8f22b9646cf0d1c81041f3b6f7635b7843d2d5cbfdeb85::sgatto {
    struct SGATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGATTO>(arg0, 6, b"Sgatto", b"Gatto", b"Gatto is a cat that often makes a mess and sometimes poses a threat to its environment. At times he is thought to be an alien. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_10p_WG_Wg_A_Av_ZQU_6af84e1091.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGATTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

