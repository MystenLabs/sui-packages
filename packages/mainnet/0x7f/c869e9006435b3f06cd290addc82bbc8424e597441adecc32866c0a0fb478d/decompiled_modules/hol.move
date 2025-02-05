module 0x7fc869e9006435b3f06cd290addc82bbc8424e597441adecc32866c0a0fb478d::hol {
    struct HOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOL>(arg0, 6, b"HOL", b"Haloo", b"Do not buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/indir_7108708730.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

