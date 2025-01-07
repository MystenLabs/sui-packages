module 0xa21f5f8da70de51826c9e8cc061b2862e1d8dbe9263005eb0c800991de31becc::dognigga {
    struct DOGNIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNIGGA>(arg0, 6, b"DOGNIGGA", b"Dog Nigga", b"Introducing Dog Nigga ($DOGNIGGA), the ultimate memecoin that celebrates our furry black companions while harnessing the power of community and fun in the crypto space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_26_192056_dbfd006c4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

