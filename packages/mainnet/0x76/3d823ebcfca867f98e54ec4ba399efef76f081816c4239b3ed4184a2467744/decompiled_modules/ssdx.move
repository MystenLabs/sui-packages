module 0x763d823ebcfca867f98e54ec4ba399efef76f081816c4239b3ed4184a2467744::ssdx {
    struct SSDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSDX>(arg0, 6, b"SSDX", b"Spunky Sdx", b"SSDX - The memecoin with purpose, transforming the meme and crypto spaces with real world value and cutting edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015903_14196cecea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSDX>>(v1);
    }

    // decompiled from Move bytecode v6
}

