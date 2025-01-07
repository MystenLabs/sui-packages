module 0x5f153118925da12453af666e9f49fab632bd9f13dafcd8c0adf681af7ebedf3d::wdoge {
    struct WDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGE>(arg0, 6, b"WDOGE", b"Wif Doge", b"Wif Doge Coin future memes along with bitcoin heading to the moon with Elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWUiXLD8ArpbtAqrdfLVp6zmVT9HZjsnab1kQeotkAWhi?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WDOGE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGE>>(v2, @0x5f4b7e4f80936f8d6f2550013472a9629b0a96f65fa749934aadbbe296ed66e6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

