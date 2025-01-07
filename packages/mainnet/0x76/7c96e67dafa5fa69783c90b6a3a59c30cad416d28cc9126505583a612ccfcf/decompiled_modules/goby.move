module 0x767c96e67dafa5fa69783c90b6a3a59c30cad416d28cc9126505583a612ccfcf::goby {
    struct GOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBY>(arg0, 6, b"GOBY", b"SUI GOBY", b"$GOBY He's the ultimate icon everyone dreams of becoming and the next mascot of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goby_fd8f3d5b20.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

