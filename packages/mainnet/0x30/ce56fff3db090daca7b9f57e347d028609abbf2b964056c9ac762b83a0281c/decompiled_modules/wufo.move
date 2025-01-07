module 0x30ce56fff3db090daca7b9f57e347d028609abbf2b964056c9ac762b83a0281c::wufo {
    struct WUFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUFO>(arg0, 6, b"WUFO", b"SantaWufo", x"5468652053616e74615775666f20546f6b656e2069732061206665737469766520746f6b656e20686f6c696461792063686565722077697468206578747261746572726573747269616c20616476656e747572652c20666561747572696e67206120706c617966756c20646f6720616e6420612055464f20696e206120736e6f7779204368726973746d6173206e696768742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaj_R49d6_ET_Eh_Dvv6g_Veuq_L6jv1_VP_Gd4_Y_Uhuj_Pc_Yxvb_T_As_09ddf504b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

