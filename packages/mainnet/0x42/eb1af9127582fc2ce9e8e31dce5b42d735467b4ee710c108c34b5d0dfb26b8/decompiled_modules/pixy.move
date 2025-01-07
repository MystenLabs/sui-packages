module 0x42eb1af9127582fc2ce9e8e31dce5b42d735467b4ee710c108c34b5d0dfb26b8::pixy {
    struct PIXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXY>(arg0, 6, b"PIXY", b"PixyDogSui", b"$PIXY is coming, a memecoin culture full of goodness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001232_7240c678b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

