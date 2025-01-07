module 0x6a4c52888df17ad393afad6c964ad032b35d9734b6abfe4931042339a4d27a28::suipdr {
    struct SUIPDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPDR>(arg0, 6, b"SUIPDR", b"SUIPIDERMAN", b"CTO. Dev rugged... KEEP THIS MEME ALIVE. CTO. Will update X / Website", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cto_1aa6215783.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

