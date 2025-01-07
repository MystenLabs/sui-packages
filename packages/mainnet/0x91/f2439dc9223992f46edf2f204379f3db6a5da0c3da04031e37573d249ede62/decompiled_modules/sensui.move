module 0x91f2439dc9223992f46edf2f204379f3db6a5da0c3da04031e37573d249ede62::sensui {
    struct SENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSUI>(arg0, 6, b"Sensui", b"SenSui: Master of blockchain", x"4d61737465722074686520626c6f636b636861696e2077697468202353656e5375692c20696e7370697265642062792053656e736569200a506f776572656420627920235375694e6574776f726b202453554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYK_Ovc8_Wc_AA_Km_XL_26d1d8cdfb.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

