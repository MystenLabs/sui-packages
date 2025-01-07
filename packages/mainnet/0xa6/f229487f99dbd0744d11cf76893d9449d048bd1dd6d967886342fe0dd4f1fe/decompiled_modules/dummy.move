module 0xa6f229487f99dbd0744d11cf76893d9449d048bd1dd6d967886342fe0dd4f1fe::dummy {
    struct DUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMMY>(arg0, 6, b"DUMMY", b"Meme Coins For Dummies", b"Your quant's quant's meme trading handbook for the criminally retarded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3453245_0d223c4102.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

