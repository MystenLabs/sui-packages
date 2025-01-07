module 0xa4d4633b4d3ef91e58dcc483a8cfe03f4769ef087831b75f0d3ff28a76feefc7::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 6, b"DOLPHIN", b"Winter Dolphin", b"The legendary Winter, the only dolphin in the world living with a prosthetic tail, will soon be in SUI as well.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc7jvga_Wg_AA_Jm_Jv_04683cbda3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

