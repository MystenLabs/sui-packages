module 0x43436cb4949559f0adaa0aabe45d4a9809183133b393813db1d8fceb1ee875eb::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"Pochita", b"Pochita on sui", b"$Pochita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_Fg_Npu_YO_400x400_f83e71980f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

