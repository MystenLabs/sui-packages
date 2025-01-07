module 0xbb86f02cfa9eba1ae6bf66455d783f5468f93c013ea1b0d3b30d61db70b2e512::brs {
    struct BRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRS>(arg0, 6, b"BRS", b"Breaking Sui", b"Breaking Sui is the ultimate memecoin for those who want to \"break bad\" in the world of crypto! Inspired by the infamous series, this coin takes the chemistry of high-stakes trading and mixes it with the decentralized power of the Sui blockchain. Just like Walter White's descent into chaos, traders here cook up their own fortune (or meltdown) in the volatile world of memecoins. With each pump and dump, you'll feel like you're one step closer to your own empirebut remember, tread lightly.  #SayMyCoin #CryptoBlue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/perfs_4cb367ce52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

