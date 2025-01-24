module 0x4ba95d10cdd7a1ae81177ebf7f91bc9daf947706c220a86fd555f7d7d260de1::trumpsons {
    struct TRUMPSONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSONS>(arg0, 6, b"Trumpsons", b"Trump in Simpsons", x"57656c636f6d6520746f205472756d70736f6e730a41206d656d6520746f6b656e20696e737069726564206279207468652068696c6172696f7573206d6978206f66205472756d7020616e64205468652053696d70736f6e732e2049747320626f6c642c2066756e6e792c20616e6420616c6c2061626f7574206272696e67696e6720736f6d65206c69676874686561727465642066756e20746f207468652063727970746f20776f726c642e204a756d7020696e20616e642062652070617274206f6620746865206a6f6b6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trumpsons_Movepump1920x1920_ezgif_com_video_to_gif_converter_2_937275bb4d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

