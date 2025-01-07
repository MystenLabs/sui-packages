module 0x55c3f5bca78282a67714bc5474cf36439e0dc65a0ea660d60ef9342e9b596ef7::wuf {
    struct WUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUF>(arg0, 6, b"WUF", b"wuf", b"Rogue team member wanted to take over to fud, but $wuf stays on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x883afca4b56fae95817b16ccda40d0d22025ae3f0ef8c5d450d9c0a6ea41f29e_wuf_wuf_023feb1619.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

