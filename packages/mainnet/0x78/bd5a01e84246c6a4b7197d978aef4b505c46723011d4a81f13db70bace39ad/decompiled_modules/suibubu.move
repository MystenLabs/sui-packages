module 0x78bd5a01e84246c6a4b7197d978aef4b505c46723011d4a81f13db70bace39ad::suibubu {
    struct SUIBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUBU>(arg0, 9, b"SUIBUBU", b"Sui Bubu", b"https://x.com/suibubuland | https://t.me/suibubuland | https://www.suibubu.meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/Qmav9XdJaP67UtvCFnYmzWQdL84AdFUpWf3CwifHpnMRsb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBUBU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUBU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

