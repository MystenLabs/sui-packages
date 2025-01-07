module 0x12c5bb1956192911ab0433fdcb6ccf4536fa5668f4293e6f1e544263324d760c::whalesin {
    struct WHALESIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALESIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALESIN>(arg0, 6, b"WHALESIN", b"Whales are in", b"Whales In: Inspired by the iconic trader phrase, this memecoin captures the thrill of seeing big players dive into action. Built on Sui for speed and efficiency, $Whalesin is for those who ride the waves of market momentum. Its more than a coinits a movement for degens who know when to follow the splash and make their own.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_071546_908_f109606313.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALESIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALESIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

