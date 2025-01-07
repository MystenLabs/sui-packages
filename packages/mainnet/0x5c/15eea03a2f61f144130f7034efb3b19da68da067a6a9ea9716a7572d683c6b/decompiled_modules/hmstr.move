module 0x5c15eea03a2f61f144130f7034efb3b19da68da067a6a9ea9716a7572d683c6b::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTR>(arg0, 6, b"HMSTR", b"Hamster Kombat", b"When you thought you were just adopting a cute hamster, but now hes deep into crypto, fighting for dominance on the blockchain battlefield!  Every $HAMSTERCOMBAT token represents not just a fighter, but a legend in the making. Stake, battle, and conquer  because in this arena, only the strongest hamsters survive... after they've stacked some coins! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HMSTR_889a1aef55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

