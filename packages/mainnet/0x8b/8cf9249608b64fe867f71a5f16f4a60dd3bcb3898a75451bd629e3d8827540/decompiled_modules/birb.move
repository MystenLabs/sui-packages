module 0x8b8cf9249608b64fe867f71a5f16f4a60dd3bcb3898a75451bd629e3d8827540::birb {
    struct BIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRB>(arg0, 6, b"BIRB", b"SUIBIRB", x"2442495242202d204a7573742061206c696c206269726220696e20612062696720626c756520736b790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BRE_3p_8_400x400_9488fd2de7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

