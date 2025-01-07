module 0x3ad90e1fb6f585a8a4a5e06bd638acf7fb20b912b0c959f8aa800e9e3055cf69::sbit {
    struct SBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIT>(arg0, 6, b"SBIT", b"SUI8BIT", b"$SBIT MEME ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/My_img8bit_com_Effect_e02e5f2010.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

