module 0xe0fafd27af919d8595830459143e098d0f066f2503ee90528b9f975f6ea1672e::bayc {
    struct BAYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYC>(arg0, 6, b"BAYC", b"Sui Bored Apes", b"Airdropping 10,000 Bored Ape Yacht Clubs To The Sui Community & Holders Of $BAYC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bored_apes_0fd8de5322.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

