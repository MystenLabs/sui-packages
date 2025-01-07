module 0x7eec076038d564a2ebaba22c1f0cdd3b417b0faa9d2123b3a5c926f4e0dffca3::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"Suipids", b"Suipids on $SUI. You would have to be pretty suipid to buy a coin called suipids, but as degens, we are already pretty suipid! Suipids is the representation of every degen in crypto, simply put, Suipid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_b151071f1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

