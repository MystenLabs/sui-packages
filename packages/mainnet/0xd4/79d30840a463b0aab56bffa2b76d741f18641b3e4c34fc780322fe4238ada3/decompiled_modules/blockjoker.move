module 0xd479d30840a463b0aab56bffa2b76d741f18641b3e4c34fc780322fe4238ada3::blockjoker {
    struct BLOCKJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCKJOKER>(arg0, 6, b"BlockJoker", b"SuiJoker", b"The mining activity will run until the RGB protocol launches on the Bitcoin mainnet. Right now, the RGB audit organized by Bitfinex is in progress. BlockJoker will distribute $Joker on the RGB mainnet based on your earnings, including mining rewards, referral bonuses, and testnet rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/222_41039a3411.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOCKJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

