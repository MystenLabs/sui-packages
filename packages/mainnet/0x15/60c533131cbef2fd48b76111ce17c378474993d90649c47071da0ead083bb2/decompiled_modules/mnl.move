module 0x1560c533131cbef2fd48b76111ce17c378474993d90649c47071da0ead083bb2::mnl {
    struct MNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MNL>(arg0, 17784452957117455917, b"MONKEY AND THE ELEPHANT", b"MnL", b"Join the hilarious journey of the Monkey and the Elephant to the moon, all backed and supported by the community", b"https://images.hop.ag/ipfs/QmVDmAKgmV6i5QWtV5Ttr3w7eWsqCrfoEQTxzWbG7qmz51", 0x1::string::utf8(b"https://x.com/TheMnL_coin"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/MonkeyAndTheElephant"), arg1);
    }

    // decompiled from Move bytecode v6
}

