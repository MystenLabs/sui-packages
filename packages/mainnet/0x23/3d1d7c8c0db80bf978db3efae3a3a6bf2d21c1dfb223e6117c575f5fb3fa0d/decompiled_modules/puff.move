module 0x233d1d7c8c0db80bf978db3efae3a3a6bf2d21c1dfb223e6117c575f5fb3fa0d::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Jigglupuff Pokemon", b"THE FIRST POKEMON MEME SINGER ON SUI NETWORK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfurzdmjtcrxol7ja23a34jqtusmqsmxxagrbokxejsu7zs4cxnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

