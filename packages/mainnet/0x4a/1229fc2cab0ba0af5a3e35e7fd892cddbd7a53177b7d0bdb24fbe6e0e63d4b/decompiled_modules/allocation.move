module 0x4a1229fc2cab0ba0af5a3e35e7fd892cddbd7a53177b7d0bdb24fbe6e0e63d4b::allocation {
    struct UPAirdropNFT has store, key {
        id: 0x2::object::UID,
        amount: u64,
        claimed: bool,
        image_blob: 0x1::string::String,
    }

    struct ALLOCATION has drop {
        dummy_field: bool,
    }

    public fun create_and_transfer_allocation_nft(arg0: &mut 0x4a1229fc2cab0ba0af5a3e35e7fd892cddbd7a53177b7d0bdb24fbe6e0e63d4b::up::UpAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x4a1229fc2cab0ba0af5a3e35e7fd892cddbd7a53177b7d0bdb24fbe6e0e63d4b::up::is_manager(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x1::string::utf8(b"data:image/svg+xml,");
        0x1::string::append(&mut v0, 0x4a1229fc2cab0ba0af5a3e35e7fd892cddbd7a53177b7d0bdb24fbe6e0e63d4b::urlencode::encode(0x1::string::into_bytes(0x1::string::utf8(0x1::string::into_bytes(0x1::string::utf8(b"<svg width=200 height=100 xmlns=http://www.w3.org/2000/svg> <rect width=100% height=100% fill=blue /><text x=50% y=50% font-size=24 fill=white text-anchor=middle dominant-baseline=middle>1000 UP</text></svg>"))))));
        let v1 = UPAirdropNFT{
            id         : 0x2::object::new(arg3),
            amount     : arg1,
            claimed    : false,
            image_blob : v0,
        };
        0x2::transfer::public_transfer<UPAirdropNFT>(v1, arg2);
    }

    fun init(arg0: ALLOCATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ALLOCATION>(arg0, arg1);
        let v1 = 0x2::display::new<UPAirdropNFT>(&v0, arg1);
        0x2::display::add<UPAirdropNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"UP Airdrop Allocation NFT"));
        0x2::display::add<UPAirdropNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml;charset=utf8,{image_blob}"));
        0x2::display::add<UPAirdropNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An NFT representing an allocation of UP tokens."));
        0x2::display::update_version<UPAirdropNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<UPAirdropNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

