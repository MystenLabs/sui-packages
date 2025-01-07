module 0x512dac6c1957ebc54e23780ef683466df577c748efb80675c1077153940475ea::morg {
    struct MORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORG>(arg0, 6, b"MORG", b"Morg Dog", x"204d6f726720444f47202d20244d4f5247200a0a496620796f75206c696b6520446f6773207468656e20796f75276c6c2066616c6c20696e206c6f7665207769746820244d4f52470a0a54656c656772616d3a2068747470733a2f2f742e6d652f6d6f72675f69735f6d6f72670a547769747465723a2068747470733a2f2f782e636f6d2f4d6f72675f69735f6d6f72670a576562736974653a2068747470733a2f2f6d6f72672e6d6f6e737465722f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_17_2456a01c20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

