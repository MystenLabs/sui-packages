module 0xfaeaa2cd3451c7426194d4b1efede82eff9add7334a68cc1c645215e97ca6d82::ADTW {
    struct ADTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADTW>(arg0, 8, b"ADTW", b"Ancient Dynasties", b"A utility token for Ancient Dynasties earned by staking, gamified staking, and prizemoney from our P2E & PvP games and additional utilities. $ADTW has multiple use cases including purchasing trait upgrades, leveling up your Thumb Warriors skillset, and many more to be revealed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafybeicfvaqj2c6cibth7xg4j3zlxbu7exhsgcvvboc5ngo5ocsixovfia/adCoin.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADTW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADTW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

