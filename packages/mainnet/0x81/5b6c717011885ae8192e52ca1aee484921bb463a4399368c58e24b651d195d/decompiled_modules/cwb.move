module 0x815b6c717011885ae8192e52ca1aee484921bb463a4399368c58e24b651d195d::cwb {
    struct CWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWB>(arg0, 6, b"CWB", b"catwifboobs", b"only a catwifboobs nothing else ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cat_With_Boobs_8de589b989.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

