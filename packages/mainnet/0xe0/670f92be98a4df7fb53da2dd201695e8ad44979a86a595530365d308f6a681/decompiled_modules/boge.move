module 0xe0670f92be98a4df7fb53da2dd201695e8ad44979a86a595530365d308f6a681::boge {
    struct BOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGE>(arg0, 6, b"BOGE", b"SUI BOGE", b"Introducing Boge, the most sui dog on the blockchain scene. Born in a lab on Sui, BOGE is the genetic clone of DOGE with a blue twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_boge2_01a659c5a3_072e52ce17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

