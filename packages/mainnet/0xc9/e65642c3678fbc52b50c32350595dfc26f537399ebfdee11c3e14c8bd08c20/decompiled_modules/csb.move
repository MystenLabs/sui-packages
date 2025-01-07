module 0xc9e65642c3678fbc52b50c32350595dfc26f537399ebfdee11c3e14c8bd08c20::csb {
    struct CSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSB>(arg0, 6, b"CSB", b"coldest Sponge breathing", b"@blknoiz06", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unbenannt_50_796a378b80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

