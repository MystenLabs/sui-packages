module 0xa57bebe7005a9809cbaf65610117662d6ae36d7c5001670245f8faa1650882c9::bdc {
    struct BDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDC>(arg0, 6, b"BDC", b"BIG D CLUB", b"Lets get stiff!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_14_a_I_s_17_06_32_1fdc26857d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

