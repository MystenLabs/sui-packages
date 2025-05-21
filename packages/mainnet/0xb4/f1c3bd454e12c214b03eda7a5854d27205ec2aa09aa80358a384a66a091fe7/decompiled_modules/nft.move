module 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct NFT1 has drop {
        dummy_field: bool,
    }

    struct NFT2 has drop {
        dummy_field: bool,
    }

    struct NFT3 has drop {
        dummy_field: bool,
    }

    struct Public<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
        royalty_wallet: address,
        royalty_percentage: u64,
        rarity: u64,
    }

    struct RoyaltyPaid has copy, drop {
        nft_id: address,
        royalty_wallet: address,
        amount: u64,
    }

    public fun add_field<T0>(arg0: &0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::cap::AdminCap, arg1: &mut 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::Counter) {
        assert!(0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::packagee::version() == 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::version(arg1), 0);
        0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::add_field<T0>(arg1);
    }

    public fun get_rarity<T0>(arg0: &Public<T0>) : u64 {
        arg0.rarity
    }

    public fun get_royalty_info<T0>(arg0: &Public<T0>) : (address, u64) {
        (arg0.royalty_wallet, arg0.royalty_percentage)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Public<NFT1>>(&v0, arg1);
        0x2::display::add<Public<NFT1>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"NFT #{mint_number}"));
        0x2::display::add<Public<NFT1>>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<Public<NFT1>>(&mut v1, 0x1::string::utf8(b"royalty"), 0x1::string::utf8(b"{royalty_percentage} bps"));
        0x2::display::add<Public<NFT1>>(&mut v1, 0x1::string::utf8(b"royalty_wallet"), 0x1::string::utf8(b"{royalty_wallet}"));
        0x2::transfer::public_share_object<0x2::display::Display<Public<NFT1>>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun list_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk::RoyaltyConfig, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        0x2::kiosk::place_and_list<Public<T0>>(arg0, arg1, 0x2::kiosk::take<Public<T0>>(arg0, arg1, 0x2::object::id_from_address(arg3)), arg4);
    }

    public fun mint_and_transfer_public<T0: drop>(arg0: &0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::cap::AdminCap, arg1: &mut 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::Counter, arg2: &0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk::RoyaltyConfig, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::packagee::version() == 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::version(arg1), 0);
        assert!(arg4 <= 10000, 1);
        0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::incr_counter<T0>(arg1);
        let v0 = Public<T0>{
            id                 : 0x2::object::new(arg6),
            mint_number        : 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::counter::num_minted<T0>(arg1),
            royalty_wallet     : 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk::get_royalty_wallet(arg2),
            royalty_percentage : arg4,
            rarity             : arg5,
        };
        let (v1, v2) = 0x2::kiosk::new(arg6);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::place<Public<T0>>(&mut v4, &v3, v0);
        0x2::kiosk::set_allow_extensions(&mut v4, &v3, true);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg3);
    }

    public entry fun sell_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk::RoyaltyConfig, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        let v0 = 0x2::kiosk::take<Public<T0>>(arg0, arg1, 0x2::object::id_from_address(arg3));
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4) * v0.royalty_percentage / 10000;
        let v2 = 0x2::object::uid_to_inner(&v0.id);
        let v3 = RoyaltyPaid{
            nft_id         : 0x2::object::id_to_address(&v2),
            royalty_wallet : 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk::get_royalty_wallet(arg2),
            amount         : v1,
        };
        0x2::event::emit<RoyaltyPaid>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1, arg5), 0xb4f1c3bd454e12c214b03eda7a5854d27205ec2aa09aa80358a384a66a091fe7::kiosk::get_royalty_wallet(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<Public<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

