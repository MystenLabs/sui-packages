module 0xe5d93cbaebd71d1f0f433646d8c3551078d182eb3491ea36d8f5e0b5e56123c0::VENKO {
    struct VENKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENKO>(arg0, 6, b"VENKO", b"VENKO", b"This friendly alien loves to make new friends and to abduct cute cuddly pets, and captivated by the marvels of the Solana blockchain, and holding immense respect for Anatoly Yakovenko, this friendly alien decided to abduct Anatoly's last five letters. $VENKO acts as a digital passport to an exclusive community where he united Alien, UAP and Crypto enthusiasts, all under the banner of mutal curiosity and camaraderie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://black-written-grasshopper-675.mypinata.cloud/ipfs/QmYg9AKqV3a6cDGZ2CP4wZFPnrytDFsseLuijjSDMC6TrH"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VENKO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENKO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

