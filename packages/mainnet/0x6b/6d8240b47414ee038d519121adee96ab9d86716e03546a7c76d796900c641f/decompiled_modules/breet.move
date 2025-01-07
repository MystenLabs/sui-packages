module 0x6b6d8240b47414ee038d519121adee96ab9d86716e03546a7c76d796900c641f::breet {
    struct BREET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREET>(arg0, 6, b"BREET", b"Breet Sui", b"happy BREET on Sui ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29743_e7c436dc11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREET>>(v1);
    }

    // decompiled from Move bytecode v6
}

