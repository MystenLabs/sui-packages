module 0xb0157895aa2653d56247868be9e306ff2f79b1d4609476e333849cd91c0bdde::nfccash {
    struct NFCCASH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NFCCASH>, arg1: 0x2::coin::Coin<NFCCASH>) {
        0x2::coin::burn<NFCCASH>(arg0, arg1);
    }

    fun init(arg0: NFCCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFCCASH>(arg0, 6, b"NFCCASH", b"NFC CASH", b"#4.0 SOON TO WORK AT ANY NFC CASH REGISTER/PHONE THAT ACCEPTS SUI/SLUSH PAYMENTS. DIFFERENT VERSIONS TO COME WITH DIFFERENT ARTWORK. ENJOY! BEST OF LUCK! NOT FINANCIAL ADVICE - USE AT YOUR OWN RISK. I AM NOT LIABLE FOR ANY LOSS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiexnxp2drodkryiox2dishrm452jglo7geikiryixkxkg3q2jxwlu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFCCASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFCCASH>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NFCCASH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NFCCASH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

