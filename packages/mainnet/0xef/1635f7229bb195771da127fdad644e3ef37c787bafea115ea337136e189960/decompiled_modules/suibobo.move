module 0xef1635f7229bb195771da127fdad644e3ef37c787bafea115ea337136e189960::suibobo {
    struct SUIBOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOBO>(arg0, 6, b"SUIBOBO", b"SuiBobo", b"Welcome SuiBobo, the meme coin where Bobo your favorite laid-back  from the Matt Furie universe makes a splash on the Sui Blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_23_16_47_946f502a2f_644645d52b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

