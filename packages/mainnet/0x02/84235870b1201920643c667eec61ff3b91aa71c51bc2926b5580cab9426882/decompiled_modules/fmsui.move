module 0x284235870b1201920643c667eec61ff3b91aa71c51bc2926b5580cab9426882::fmsui {
    struct FMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMSUI>(arg0, 6, b"FMSui", b"For Men on Sui", b" First token love men to be Freeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000122055_9a772ab609.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

