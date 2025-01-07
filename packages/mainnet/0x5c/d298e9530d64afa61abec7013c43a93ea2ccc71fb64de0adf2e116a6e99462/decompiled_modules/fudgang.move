module 0x5cd298e9530d64afa61abec7013c43a93ea2ccc71fb64de0adf2e116a6e99462::fudgang {
    struct FUDGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGANG>(arg0, 6, b"FUDGANG", b"Fuddies Gang", b"AI meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fd13c566b20f94d314b2d18de0a916ee3f5a99cdaf8d247d11fbe5bc5b933ce7_b30c18af37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

