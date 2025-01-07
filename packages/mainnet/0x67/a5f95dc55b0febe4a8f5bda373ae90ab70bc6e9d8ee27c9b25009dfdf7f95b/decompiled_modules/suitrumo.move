module 0x67a5f95dc55b0febe4a8f5bda373ae90ab70bc6e9d8ee27c9b25009dfdf7f95b::suitrumo {
    struct SUITRUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMO>(arg0, 6, b"SUITRUMO", b"SUI TRUMP", b"First token on SUI with TRUMP support! We know he will win, and we will be on top. Join the OG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_N_N_N_N_D_N_D_N_D_D_D_D_D_D_D_D_D_D_N_1_36_b774030622.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

