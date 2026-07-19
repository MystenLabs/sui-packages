module 0x3cdb9b0ca6ec2a2c21d4ac79f6bcb03e995975f1105bba2ee7403c24fda0328d::tale01 {
    struct TALE01 has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        index: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        price: u64,
        max_supply: u64,
        minted_count: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        royalty_bps: u16,
        recipient: address,
        paused: bool,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        price_paid: u64,
        supply: u64,
    }

    public entry fun airdrop(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.minted_count + 1;
        let v1 = Nft{
            id    : 0x2::object::new(arg3),
            index : v0,
        };
        0x2::transfer::public_transfer<Nft>(v1, arg2);
        arg1.minted_count = v0;
    }

    fun init(arg0: TALE01, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TALE01>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Tale"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The critical pass to access archive at abc,abc,xyz"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"walrus://NX9d82Xps_mxQLAQtG_e9gQIX-T5k5fWkpZIgiMAUOs"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Link: tale01.voxxinc.xyz"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"Voxxinc.xyz"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"discord"), 0x1::string::utf8(b"https://discord.gg/cQrRasDRqB"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"twitter"), 0x1::string::utf8(b"https://x.com/VOXXinc"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"website"), 0x1::string::utf8(b"voxxinc.xyz"));
        0x2::display::update_version<Nft>(&mut v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = MintConfig{
            id            : 0x2::object::new(arg1),
            price         : 0,
            max_supply    : 0,
            minted_count  : 0,
            start_time_ms : 0,
            end_time_ms   : 0,
            royalty_bps   : 3000,
            recipient     : v3,
            paused        : false,
        };
        0x2::transfer::public_transfer<MintConfig>(v4, v3);
        let (v5, v6) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v7 = v6;
        let v8 = v5;
        0x3cdb9b0ca6ec2a2c21d4ac79f6bcb03e995975f1105bba2ee7403c24fda0328d::tale01_royalty::add<Nft>(&mut v8, &v7, 3000, v3, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v3);
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, v3);
        0x2::transfer::public_transfer<AdminCap>(v2, v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v7, v3);
    }

    public fun mint(arg0: &mut MintConfig, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Nft {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_time_ms, 1);
        assert!(arg0.end_time_ms == 0 || v0 <= arg0.end_time_ms, 2);
        assert!(arg0.max_supply == 0 || arg0.minted_count < arg0.max_supply, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.price, 4);
        let v1 = arg0.minted_count + 1;
        let v2 = Nft{
            id    : 0x2::object::new(arg3),
            index : v1,
        };
        let v3 = 0x2::tx_context::sender(arg3);
        if (arg0.price > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.price, arg3), arg0.recipient);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        arg0.minted_count = v1;
        let v4 = MintEvent{
            nft_id     : 0x2::object::id<Nft>(&v2),
            buyer      : v3,
            price_paid : arg0.price,
            supply     : arg0.minted_count,
        };
        0x2::event::emit<MintEvent>(v4);
        v2
    }

    public entry fun mint_and_transfer(arg0: &mut MintConfig, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<Nft>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun set_pause(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut MintConfig, arg2: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg3: &0x2::transfer_policy::TransferPolicyCap<Nft>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: address, arg10: u64) {
        assert!(arg8 <= 10000, 5);
        assert!(arg8 >= 3000, 5);
        assert!(arg7 == 0 || arg7 > arg6, 7);
        arg1.price = arg4;
        arg1.max_supply = arg5;
        arg1.start_time_ms = arg6;
        arg1.end_time_ms = arg7;
        let v0 = if (arg1.royalty_bps != arg8) {
            true
        } else if (arg1.recipient != arg9) {
            true
        } else {
            0x3cdb9b0ca6ec2a2c21d4ac79f6bcb03e995975f1105bba2ee7403c24fda0328d::tale01_royalty::min_amount(0x3cdb9b0ca6ec2a2c21d4ac79f6bcb03e995975f1105bba2ee7403c24fda0328d::tale01_royalty::get_config<Nft>(arg2)) != arg10
        };
        if (v0) {
            0x3cdb9b0ca6ec2a2c21d4ac79f6bcb03e995975f1105bba2ee7403c24fda0328d::tale01_royalty::update<Nft>(arg2, arg3, arg8, arg9, arg10);
            arg1.royalty_bps = arg8;
            arg1.recipient = arg9;
        };
    }

    public entry fun update_display(arg0: &mut 0x2::display::Display<Nft>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>) {
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(arg1));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"description"), 0x1::string::utf8(arg2));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(arg3));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(arg4));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(arg5));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"discord"), 0x1::string::utf8(arg6));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"twitter"), 0x1::string::utf8(arg7));
        0x2::display::edit<Nft>(arg0, 0x1::string::utf8(b"website"), 0x1::string::utf8(arg8));
        0x2::display::update_version<Nft>(arg0);
    }

    // decompiled from Move bytecode v7
}

