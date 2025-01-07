module 0xa3a5392938ce4d287412f0ecd5152ca242be8576d2dce1f5667aeca62293fb0d::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"Alien", b"Alien on sui", b"Your Gateway to the Future of Wealth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Ffile_W_Vn_Uqg_Ovgz_EZBFH_14lz9u_Kwb_dae4230c59.webp&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALIEN>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

