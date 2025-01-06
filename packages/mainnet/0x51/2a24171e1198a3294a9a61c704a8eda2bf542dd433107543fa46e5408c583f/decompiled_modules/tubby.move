module 0x512a24171e1198a3294a9a61c704a8eda2bf542dd433107543fa46e5408c583f::tubby {
    struct TUBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUBBY>(arg0, 6, b"TUBBY", b"Tubby The Frogo", b"Tubby the Frogo, the legend, the baddest frog on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tubbyprof_63cb262f66.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

