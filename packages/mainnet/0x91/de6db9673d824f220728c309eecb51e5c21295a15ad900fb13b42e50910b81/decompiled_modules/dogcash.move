module 0x91de6db9673d824f220728c309eecb51e5c21295a15ad900fb13b42e50910b81::dogcash {
    struct DOGCASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGCASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGCASH>(arg0, 9, b"DOGCASH", b"Dog wif cash", b"Dog wif cash meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/cR2b6vVn8CN95q21eTuZXoWCCeuJDHGMP6o2Toayd7g.png?size=xl&key=06c713")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGCASH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGCASH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGCASH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

