module 0xa35643c3ee6e34fd70c3c20f66edbbf9a1917914a9536adc650eca70fc96b23a::bennie {
    struct BENNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNIE>(arg0, 6, b"Bennie", b"Bennie Coin on Sui", b"A Meme Coin of Empowerment! $Bennie is all about accessing your highest potential and infinite paws-abilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_8c9aaca105.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

