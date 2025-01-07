module 0x958e4a44ad231c548c594f872faf5486c590ef04a83c1667db38c5994d645000::mery {
    struct MERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERY>(arg0, 6, b"MERY", b"Mistery", b"Mistery on CRO ($MERY) transcends the typical meme token. Its a captivating phenomenon that intrigues and draws you in. With its innovative and inclusive approach, this lovely ghost is redefining the landscape of meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_H_Sb_NET_400x400_f2b7c9a516.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

