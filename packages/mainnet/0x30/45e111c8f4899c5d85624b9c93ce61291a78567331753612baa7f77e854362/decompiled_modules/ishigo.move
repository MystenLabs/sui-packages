module 0x3045e111c8f4899c5d85624b9c93ce61291a78567331753612baa7f77e854362::ishigo {
    struct ISHIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHIGO>(arg0, 6, b"ISHIGO", b"Ishigo on Sui", b"$ISHIGO is a Memecoin that draws inspiration from the oldest Shiba Inu registered by the Japanese Dog Preservation Society.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_Zl_V_Ze_Z_400x400_9e9aac5536.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISHIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

