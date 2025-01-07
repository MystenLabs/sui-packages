module 0xe87e017cf8e1eb9b848dcbadd8d9ec3795aec69fbb0dac934125ba89663410ce::sut {
    struct SUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUT>(arg0, 6, b"SUT", b"Super Useless Token", b"Proudly the Most Useless Token on SUI EVER created. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sop_u_Z_Rw_400x400_8d0faf3452.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

