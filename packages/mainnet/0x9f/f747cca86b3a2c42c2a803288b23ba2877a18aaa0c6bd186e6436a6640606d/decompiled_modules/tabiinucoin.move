module 0x9ff747cca86b3a2c42c2a803288b23ba2877a18aaa0c6bd186e6436a6640606d::tabiinucoin {
    struct TABIINUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TABIINUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TABIINUCOIN>(arg0, 6, b"Tabiinucoin", b"TABI INU", x"546162692c206120666561726c6573732077617272696f722c20656e746572732061206369747920636f6e74726f6c6c65642062792061206861727368207461782073797374656d2e0a0a546f20737572766976652c2065766572796f6e65206d757374207061792c206275742054616269207265667573657320746f20626f7720646f776e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Eg_i_Al_400x400_de02fa4305.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TABIINUCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TABIINUCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

