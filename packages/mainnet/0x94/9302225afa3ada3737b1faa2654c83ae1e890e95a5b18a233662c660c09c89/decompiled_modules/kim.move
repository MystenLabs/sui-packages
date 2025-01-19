module 0x949302225afa3ada3737b1faa2654c83ae1e890e95a5b18a233662c660c09c89::kim {
    struct KIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIM>(arg0, 6, b"KIM", b"Kim Jong Un", b"KIM JONG UN official KimJongUn meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027285_d0726429ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

