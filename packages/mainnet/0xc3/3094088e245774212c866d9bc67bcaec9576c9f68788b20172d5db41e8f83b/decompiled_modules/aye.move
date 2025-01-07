module 0xc33094088e245774212c866d9bc67bcaec9576c9f68788b20172d5db41e8f83b::aye {
    struct AYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYE>(arg0, 6, b"AYE", b"Aye Koyo", b"I am AYE KOYO, the aye aye with the magic finger. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aeyo_9cb47e924e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

