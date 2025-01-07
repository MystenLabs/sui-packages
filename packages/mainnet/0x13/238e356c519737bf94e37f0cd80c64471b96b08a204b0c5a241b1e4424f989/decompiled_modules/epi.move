module 0x13238e356c519737bf94e37f0cd80c64471b96b08a204b0c5a241b1e4424f989::epi {
    struct EPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPI>(arg0, 9, b"EPI", b"EPI", b"Watch out for seizures, Epileptic on SUI is here! Ultra organic cult on SUI with adverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmSrdQEjznjoLGwGwyug7H7iGbjzrfeXKvSj1XLtYXwL7K"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPI>>(v1);
        0x2::coin::mint_and_transfer<EPI>(&mut v2, 1000000000000000000, @0x591d022baa8dd6959ae6106f921a1cdd1e404ef715dd5f26f84548f2eb76ba4a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EPI>>(v2);
    }

    // decompiled from Move bytecode v6
}

