module 0xf34369f03bf1ce84a25043408ad420adab15c1518e729a064249569d887dcf09::fap {
    struct FAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAP>(arg0, 9, b"FAP", b"Fart Ai Protocol", b"Enter the realm of Fart AI Protocol, where the explosive power of AI meets the primal satisfaction of fapping within the Terminal of Truths ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTc7f2MLZg1FAqefQBoxWqfKtzWyi5WXSxTh7rgN7rQbD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

