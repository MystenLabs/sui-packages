module 0x1512fbf99602795c86a2a50bef34d1d6774bb1274cdc6cc21d2af0d6ea11aec9::disco {
    struct DISCO has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DISCO>, arg1: 0x2::coin::Coin<DISCO>) {
        0x2::coin::burn<DISCO>(arg0, arg1);
    }

    fun init(arg0: DISCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISCO>(arg0, 9, b"DISCO", b"DISCO RAVE", x"31393730e5b9b4e4bba3e381abe6b581e8a18ce38197e3819fe99fb3e6a5bde382b8e383a3e383b3e383abe38284e38380e383b3e382b9e382b9e382bfe382a4e383abe38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.app.goo.gl/QHWvAUqSCxLPWNw18")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DISCO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISCO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DISCO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DISCO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

