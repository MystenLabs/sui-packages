module 0x3a0643a70345cffb2f261c3ad179d7652b3352f3d2f12838c0045ff96c0dab2a::bnny {
    struct BNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNNY>(arg0, 6, b"BNNY", b"BUNNY ON SUI", b"$BUNNY is the latest sensation in the memecoin universe, bringing laughter and lighthearted fun to the crypto space. With its adorable blue bunny mascot. $BUNNY is designed for those who love the thrill of the meme world. Get ready to hop into the next big trend in crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunny_4451b289da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

