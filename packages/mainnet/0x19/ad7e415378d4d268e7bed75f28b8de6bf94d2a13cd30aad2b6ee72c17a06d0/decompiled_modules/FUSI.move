module 0x19ad7e415378d4d268e7bed75f28b8de6bf94d2a13cd30aad2b6ee72c17a06d0::FUSI {
    struct FUSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSI>(arg0, 3, b"FUSI", b"FUSI", b"FUSI token is the heart of our thriving SUISHI community, fueling all activities within the ecosystem. FUSI is a key that unlocks the full potential of the SUISHI world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafybeiervb2ah2hiymmyw75m6b4bjfh5m5ksdgfgn3n2crn5mjeycgs5fm/logo%20SUISHI-04%20-%20Kha%CC%81nh%20Tie%CC%82%CC%81t%20Le%CC%82%20Ba%CC%89o.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

