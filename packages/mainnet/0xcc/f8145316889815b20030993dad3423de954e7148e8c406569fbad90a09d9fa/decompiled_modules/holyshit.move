module 0xccf8145316889815b20030993dad3423de954e7148e8c406569fbad90a09d9fa::holyshit {
    struct HOLYSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYSHIT>(arg0, 9, b"HolyShit", b"Truth Terminal Final Coin", b"Holyshit: meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTVy5x5BgNphbqFxs1FVL1qdTT1sWMARsRAe3uAAvyqdA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOLYSHIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYSHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYSHIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

