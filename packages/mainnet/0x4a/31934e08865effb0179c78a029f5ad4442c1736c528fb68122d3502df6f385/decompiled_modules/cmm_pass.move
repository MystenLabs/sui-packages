module 0x4a31934e08865effb0179c78a029f5ad4442c1736c528fb68122d3502df6f385::cmm_pass {
    struct CMM_PASS has drop {
        dummy_field: bool,
    }

    struct CmmAirdropPass has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun airdrop(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = CmmAirdropPass{id: 0x2::object::new(arg2)};
            0x2::transfer::transfer<CmmAirdropPass>(v1, 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun burn(arg0: CmmAirdropPass) {
        let CmmAirdropPass { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CMM_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CMM_PASS>(arg0, arg1);
        let v1 = 0x2::display::new<CmmAirdropPass>(&v0, arg1);
        0x2::display::add<CmmAirdropPass>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"CMM Airdrop Pass"));
        0x2::display::add<CmmAirdropPass>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Cant Miss Media Airdrop Pass. Soulbound and non-transferable."));
        0x2::display::add<CmmAirdropPass>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://scarlet-top-iguana-917.mypinata.cloud/ipfs/bafybeic33j5pt5m6ooh5ukcvzxh7fzcnoccc3xtdymiuv7nomkrf62lxnq"));
        0x2::display::add<CmmAirdropPass>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Cant Miss Media"));
        0x2::display::update_version<CmmAirdropPass>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CmmAirdropPass>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

