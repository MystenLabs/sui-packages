module 0x213ec84314316b7e016079cdc0dc6dc52b03b1193af221343f27f8debb1ce294::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"lolcow", b"Harvesting a community of Rage-Baiters. Let's bring the lols and the rage together with lolcow official. This will be a community coin. Will require the help of the community to help grow an organize! Are you in? Do you enjoy trolling? Then this is the token for you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxbdvxsgkqiuoz4a5yi6p7kvgqfgdksynhx7bfcsysm2w4kwlhcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

