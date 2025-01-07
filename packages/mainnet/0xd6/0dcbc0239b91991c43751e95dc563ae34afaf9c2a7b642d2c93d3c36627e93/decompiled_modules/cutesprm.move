module 0xd60dcbc0239b91991c43751e95dc563ae34afaf9c2a7b642d2c93d3c36627e93::cutesprm {
    struct CUTESPRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTESPRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTESPRM>(arg0, 6, b"CUTESPRM", b"CUTE SPERM", b"Thrse is just a liste cutie sperm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CC_Cute_Sperm_75fba70653.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTESPRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTESPRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

