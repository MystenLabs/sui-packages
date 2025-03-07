module 0xeb39b7cbf869b2708eca0deab4aa2cfb185dd53cdd6205eccd4365bcd6ba0936::bert {
    struct BERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERT>(arg0, 9, b"BERT", b"BERT", b"BERT is a new token on the Sui blockchain, combining advanced AI principles with decentralized finance. It offers seamless participation in staking, governance, and dApps, leveraging Sui's scalability and efficiency to power innovative blockchain solutions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1516063772082941956/WfGqHH8e.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BERT>(&mut v2, 10000000010000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

