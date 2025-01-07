module 0xaa0a86a90b7f7c0145248680855255c0041db8e785d30fa896d0d207a7a263ba::catbox {
    struct CATBOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOX>(arg0, 6, b"CATBOX", b"Cat Wif Box", x"4361742077696620426f78200a0a68747470733a2f2f782e636f6d2f656d616e6162696f2f7374617475732f313832313130353030363330363633313638303f733d3436", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_d6e101b56f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

