module 0xc018359177aa44eb03f7e134648f6355fc7da364ebaeba8435a38a600e605a12::suikachu {
    struct SUIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKACHU>(arg0, 6, b"SUIKACHU", b"SuiKachu", b"Description: SUIKACHU the wettest coin on SUI! What do you get when you mix water and electricity, SUIKACHU!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029262_743313ba4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

