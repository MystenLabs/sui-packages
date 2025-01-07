module 0x810a5a576cf749f33be5af43ff1ad12d15637382fe10e0ac5cfbafa92f7b6d6e::pppy {
    struct PPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPY>(arg0, 6, b"PPPY", b"SUIPUPPY", b"The Dog of the Sui Chain MEME Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197080_c455d42c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

