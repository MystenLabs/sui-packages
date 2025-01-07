module 0xfc70c94b6be5bfba42eace8b8d7f77b0aa86794e7ad0254326a43fdbdc8c4e70::faucet {
    struct Faucet has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0xfc70c94b6be5bfba42eace8b8d7f77b0aa86794e7ad0254326a43fdbdc8c4e70::mycoin::MYCOIN>,
    }

    public entry fun create_faucet(arg0: 0x2::coin::TreasuryCap<0xfc70c94b6be5bfba42eace8b8d7f77b0aa86794e7ad0254326a43fdbdc8c4e70::mycoin::MYCOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Faucet{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<Faucet>(v0);
    }

    public entry fun request_coins(arg0: &mut Faucet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfc70c94b6be5bfba42eace8b8d7f77b0aa86794e7ad0254326a43fdbdc8c4e70::mycoin::MYCOIN>>(0x2::coin::mint<0xfc70c94b6be5bfba42eace8b8d7f77b0aa86794e7ad0254326a43fdbdc8c4e70::mycoin::MYCOIN>(&mut arg0.treasury_cap, 10000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

