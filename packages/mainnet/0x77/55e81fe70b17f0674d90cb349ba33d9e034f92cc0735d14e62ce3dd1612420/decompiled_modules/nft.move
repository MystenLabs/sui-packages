module 0x7755e81fe70b17f0674d90cb349ba33d9e034f92cc0735d14e62ce3dd1612420::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct MyNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        count: u64,
    }

    struct MyNftGenerator has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    public fun create_collection(arg0: &mut 0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::launchpad::Launchpad, arg1: &0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::collection::new<MyNft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun generate_nft(arg0: &mut MyNftGenerator, arg1: &mut 0x2::tx_context::TxContext) : MyNft {
        let v0 = MyNft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"NFT"),
            description : 0x1::string::utf8(b"NFT"),
            image_url   : 0x1::string::utf8(b"https://tradeport.mypinata.cloud/ipfs/Qmai3CRQTrtTFWuCfF56jvLZZSqTwQvN1EwUAFK3Mt3GhF?pinataGatewayToken=sd9Ceh-eJIQ43PRB3JW6QGkHAr8-cxGhhjDF0Agxwd_X7N4_reLPQXZSP_vUethU"),
            count       : arg0.counter,
        };
        arg0.counter = arg0.counter + 1;
        v0
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<MyNft>(&v0, arg1);
        0x2::display::add<MyNft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{character.name}"));
        0x2::display::add<MyNft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{character.description}"));
        0x2::display::add<MyNft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<MyNft>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"Hokko Launchpad"));
        0x2::display::update_version<MyNft>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNft>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = MyNftGenerator{
            id      : 0x2::object::new(arg1),
            counter : 0,
        };
        0x2::transfer::share_object<MyNftGenerator>(v2);
    }

    public entry fun mint(arg0: &mut 0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::collection::Collection, arg1: &mut 0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::launchpad::Launchpad, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut MyNftGenerator, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = generate_nft(arg4, arg5);
        0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::collection::mint<MyNft>(arg0, arg1, v0, arg2, arg3, arg5);
    }

    public entry fun mint_with_kiosk(arg0: &mut 0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::collection::Collection, arg1: &mut 0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::launchpad::Launchpad, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<MyNft>, arg7: &mut MyNftGenerator, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = generate_nft(arg7, arg8);
        0xd3e603daf164c1b5c285650ab393743fbec9e1dbe30e2a7da006d8ab950c62aa::collection::mint_with_kiosk<MyNft>(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    // decompiled from Move bytecode v6
}

