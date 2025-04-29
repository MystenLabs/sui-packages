module 0x92e64ad6ec49017fcbfc96990e4896c961e44643a6f44dec807a0646bbdf2ef8::dogefather {
    struct DOGEFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEFATHER>(arg0, 9, b"DOGEFATHER", b"DOGEFATHER", b"https://x.com/cb_doge/status/1917048220095517170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSrThxBQPHQZZ5kdrNdbGzgV6fypQnjiBSZ1xvTapxzQ2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGEFATHER>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEFATHER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

