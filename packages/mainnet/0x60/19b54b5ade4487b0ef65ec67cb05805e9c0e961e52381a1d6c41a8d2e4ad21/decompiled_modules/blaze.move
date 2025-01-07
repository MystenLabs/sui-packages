module 0x6019b54b5ade4487b0ef65ec67cb05805e9c0e961e52381a1d6c41a8d2e4ad21::blaze {
    struct BLAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZE>(arg0, 6, b"BLAZE", b"Blaze", b"!Ready to burn through the crypto scene on Sui?  $BLAZE is fierce, fast, and on fireperfect for those who like their memes as hot as their gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020927_92a80425af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

