module 0xd447ee044b98bc3544cac553083bc1b8ed1221daae0d425058bccd5062a79516::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"Alien", b"Alien On Sui", x"54686520666972737420416c69656e206f6e20535549206e6574776f726b200a596f7572206765746177617920746f2074686520667574757265206f66207765616c7468", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_W_Vn_Uqg_Ovgz_EZBFH_14lz9u_Kwb_b5ca6844d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

