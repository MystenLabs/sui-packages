module 0x3a5b0dd9024c2c40ebc50291af7c0d683045b83a1f557f711366bbdc49f34cb2::jizzlord {
    struct JIZZLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIZZLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIZZLORD>(arg0, 6, b"JizzLord", b"SuiJizzLord", b"Join the meme community with Buy & Burn tokenomics, our own casino and the pioneers of Pornfi! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lzk8_Fpd_A_400x400_7d6dbf333c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIZZLORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIZZLORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

