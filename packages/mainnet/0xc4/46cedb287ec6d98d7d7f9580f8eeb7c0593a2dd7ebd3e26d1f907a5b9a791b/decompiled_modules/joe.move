module 0xc446cedb287ec6d98d7d7f9580f8eeb7c0593a2dd7ebd3e26d1f907a5b9a791b::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"JOE", b"Depressed Joe", b"Depressed Joe got rugged one too many times on SUI. Now, he's launching his own token to flip the script. No rugs, just riches for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFP_trans_3_8fb081f5b3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

