module 0xff3c4a6ed940ba8235f18c83141b38ca6ebb3f16c96a8b7e311b98ae4ff4ad85::suihot {
    struct SUIHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOT>(arg0, 6, b"SUIHOT", b"Suihot", b"$SUIHOT fight with men with strong women, we are strong to do several times", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053424_fa7f0ebdfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

