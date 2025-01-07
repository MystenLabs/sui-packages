module 0x52de348b0dd8253c756213a8ecb46364291d4adb7191d60a0b6d97a0e233b736::borks {
    struct BORKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORKS>(arg0, 6, b"BORKS", b"BORK ON SUI", b"First BORK ON SUI: https://www.borkonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_3_bf39494416.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

