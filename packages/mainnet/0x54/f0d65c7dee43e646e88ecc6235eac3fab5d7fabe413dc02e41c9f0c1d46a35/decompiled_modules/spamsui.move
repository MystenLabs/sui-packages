module 0x54f0d65c7dee43e646e88ecc6235eac3fab5d7fabe413dc02e41c9f0c1d46a35::spamsui {
    struct SPAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAMSUI>(arg0, 6, b"SPAMSUI", b"SPAMMMMM", b"\"Spam to Earn\" a.k.a. \"Proof of Spam\" on Sui. Welcome to the community-owned page of $SPAM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_211654932_f3b59260a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

