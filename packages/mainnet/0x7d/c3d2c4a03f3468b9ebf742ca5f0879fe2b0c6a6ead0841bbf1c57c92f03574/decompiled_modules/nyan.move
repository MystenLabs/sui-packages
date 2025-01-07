module 0x7dc3d2c4a03f3468b9ebf742ca5f0879fe2b0c6a6ead0841bbf1c57c92f03574::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAN>(arg0, 6, b"nyan", b"SUI NYAN", b"NYAN is a meme token on the Sui, inspired by the legendary Nyan Cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ik.imagekit.io/qsp1f71zd/nyan%20copy.png?updatedAt=1728004806868"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NYAN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

