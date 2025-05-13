module 0x2455292788271f7898bc3321ddd173153b34d5844e9fe63261a35a7eb2d63927::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"EvoFrog", b"He s not just another meme EVF embodies growth transformation and powerThis token is ready to leap through the crypto pon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiayewkt56frjtvp6r2j3tyes4bdzsryniteol3ws6mjvgnt7oshwi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

