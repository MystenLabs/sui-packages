module 0xaff37a4c177b11d51965513f51caf75fa0cf4b864b7d9f2831d9b2c549d67fab::delulu {
    struct DELULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELULU>(arg0, 6, b"DELULU", b"deluludog", x"44454c554c55204f4e205355490a0a68747470733a2f2f742e6d652f64656c756c75646f676f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_VC_Av_E_Vv_400x400_3068a217b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELULU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELULU>>(v1);
    }

    // decompiled from Move bytecode v6
}

