module 0x2dce952c070989acbdbc1cb09dda8908389f5aa9fabc39c56c4971a0e656c631::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"DUCK on SUI", x"20546865206e657874203130303058206d656d6520636f696e206f6e20536f6c616e6120697320686572650a0a20446f6e74207761697420207468697320697320796f7572206d6f6d656e7420746f2062652072696368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hq_W_Gq_Guu_400x400_2f6f086a02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

