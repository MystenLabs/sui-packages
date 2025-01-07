module 0x7582ed7f567cbb7fbcab8cc2fd0f4e737b0aa24e6940dc95be78f89b4c13ada4::ster {
    struct STER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STER>(arg0, 6, b"STER", b"Stermon", b"HEY, I AM STERMON. IM A MONSTER, NOT A TYPICAL SCARY ONE, BUT A NICE FRIEND TO EVERYONE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91f_Nlo5_U_400x400_1_d02ea46c41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STER>>(v1);
    }

    // decompiled from Move bytecode v6
}

