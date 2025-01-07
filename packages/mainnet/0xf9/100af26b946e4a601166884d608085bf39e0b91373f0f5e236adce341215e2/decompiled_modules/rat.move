module 0xf9100af26b946e4a601166884d608085bf39e0b91373f0f5e236adce341215e2::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAT>(arg0, 6, b"RAT", b"RAT", b"SuiEmoji Rat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/rat.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

