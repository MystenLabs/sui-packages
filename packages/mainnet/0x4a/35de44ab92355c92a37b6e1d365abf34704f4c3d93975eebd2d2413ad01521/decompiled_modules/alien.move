module 0x4a35de44ab92355c92a37b6e1d365abf34704f4c3d93975eebd2d2413ad01521::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"Alien", b"Alien On Sui", b"The first Alien on SUI network and your gateway to the future of wealth! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_W_Vn_Uqg_Ovgz_EZBFH_14lz9u_Kwb_b5ca6844d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

