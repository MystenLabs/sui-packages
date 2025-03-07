module 0x556ad731ec4dde328b8dedf77b1aabc88563ff589c53078ac9390c76bf277cf6::snoopy {
    struct SNOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 694 || 0x2::tx_context::epoch(arg1) == 695, 1);
        let (v0, v1) = 0x2::coin::create_currency<SNOOPY>(arg0, 9, b"Snoopy", b"SNOOPY", x"546865206c6f7661626c652072617363616c2077686f20736e69666673206f757420616476656e74757265732c2063686173657320647265616d732c20616e6420616c7761797320656e647320757020737465616c696e672074686520736e61636b73e2809462656361757365206c696665e280997320746f6f2073686f7274206e6f7420746f2062652061206c6974746c65206d6d697363686965766f757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreid2wtahv5ktlbzpabo4umfwgyqco3q65ubsdwziv5drfelrvk3jza.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNOOPY>(&mut v2, 1000000000000000000, @0xc955e3cae6d79a24ad85d482d19770df5bf9cb1ed77af2c41415613fd80183b6, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPY>>(v2, @0xc955e3cae6d79a24ad85d482d19770df5bf9cb1ed77af2c41415613fd80183b6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

