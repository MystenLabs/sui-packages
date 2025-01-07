module 0x34ebbc5b3b4fe314bbc67d432e5aa4731c971fc0e3e0a17ed81b44baa22f8092::sonke {
    struct SONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONKE>(arg0, 6, b"SONKE", b"Sui Ponke", b"The blue monkey on th blue chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9k_Wt_a_Of_400x400_570748f059.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

