module 0x15d5bdb5544d1e662d70af6732eeb733ca2896cd5a32b82d0ef752d3532508b8::bitcoinwizard {
    struct BITCOINWIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOINWIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOINWIZARD>(arg0, 6, b"BitcoinWizard", b"Magic Internet Money", x"4d6167696320496e7465726e6574204d6f6e65793a20426974636f696e2057697a6172642072656665727320746f20616e206164766572746973656d656e740a666f7220746865202f722f426974636f696e20737562726564646974207468617420666561747572657320616e204d535061696e7420696c6c757374726174696f6e0a6f6620612077697a6172642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/250x250wizard_c6694a7161.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINWIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOINWIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

