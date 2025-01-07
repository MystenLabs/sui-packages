module 0xb6684893fff5171ae4929367e871e3daced4c809a142131413efd126a8920f19::har {
    struct HAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAR>(arg0, 6, b"HAR", b"HARMA", b"HARMA is new official token of Harecrypta community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Harma_NFT_475fb02eb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

