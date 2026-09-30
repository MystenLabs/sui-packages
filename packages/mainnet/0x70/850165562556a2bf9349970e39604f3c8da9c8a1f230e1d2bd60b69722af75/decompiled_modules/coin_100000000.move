module 0x70850165562556a2bf9349970e39604f3c8da9c8a1f230e1d2bd60b69722af75::coin_100000000 {
    struct COIN_100000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_100000000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COIN_100000000>(arg0, 6, 0x1::string::utf8(b"100000000"), 0x1::string::utf8(b"Like"), 0x1::string::utf8(b"Meet Like ($LIKE), the new cryptocurrency built purely for tipping and rewarding your favorite creators. Lightning-fast, near-zero fees, and designed to turn digital appreciation into real-world value."), 0x1::string::utf8(b"https://popularsui.xyz/media/efd7d1d4c192891bb904faa36704566f9cbe41fe441665ff92810f6fda0c9c9b.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_100000000>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COIN_100000000>>(0x2::coin_registry::finalize<COIN_100000000>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

