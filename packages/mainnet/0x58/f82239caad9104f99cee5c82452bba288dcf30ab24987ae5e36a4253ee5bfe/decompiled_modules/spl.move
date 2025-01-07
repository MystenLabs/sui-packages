module 0x58f82239caad9104f99cee5c82452bba288dcf30ab24987ae5e36a4253ee5bfe::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL>(arg0, 6, b"SPL", b"SUPOVEL", b"BEST TOKEN SPUPOVEL NOT SCAM GO 100K MKP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2_4f84b86238.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

