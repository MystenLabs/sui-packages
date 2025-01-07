module 0x60496416e9b9910956b8d4130f790781953bdc166e6a63b151f0d306a7da4da7::wait {
    struct WAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIT>(arg0, 6, b"WAIT", b"Wait on Sui", x"776169742e2e2e2054686520686f74746573742054696b546f6b207472656e642c206e6f77206f6e205375692e2074686579646f6e746c6f7665796f756c696b65696c6f7665796f752e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEW_WELCOME_NUEVO_REAL_1_c5b4b5c2ca.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

