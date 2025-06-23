module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft {
    struct BlizzardStakeNFT has key {
        id: 0x2::object::UID,
        inner: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal,
        symbol: 0x1::ascii::String,
        type_name: 0x1::type_name::TypeName,
        activation_epoch: u32,
        value: u64,
    }

    struct BLIZZARD_STAKE_NFT has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal, arg1: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_metadata::BlizzardMetadata, arg2: &mut 0x2::tx_context::TxContext) : BlizzardStakeNFT {
        BlizzardStakeNFT{
            id               : 0x2::object::new(arg2),
            inner            : arg0,
            symbol           : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_metadata::symbol(&arg1),
            type_name        : 0x1::type_name::get<T0>(),
            activation_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&arg0),
            value            : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&arg0),
        }
    }

    public(friend) fun assert_type<T0>(arg0: &BlizzardStakeNFT) {
        assert!(arg0.type_name == 0x1::type_name::get<T0>(), 16);
    }

    public(friend) fun destroy(arg0: BlizzardStakeNFT) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal {
        let BlizzardStakeNFT {
            id               : v0,
            inner            : v1,
            symbol           : _,
            type_name        : _,
            activation_epoch : _,
            value            : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun init(arg0: BLIZZARD_STAKE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"symbol"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"principal_wal_value"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"activation_epoch"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{symbol}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{symbol} Stake NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://api.winterwalrus.com/nft/{id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{value}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{activation_epoch}"));
        let v4 = 0x2::package::claim<BLIZZARD_STAKE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BlizzardStakeNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BlizzardStakeNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<BlizzardStakeNFT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
    }

    public fun join(arg0: &mut BlizzardStakeNFT, arg1: BlizzardStakeNFT) {
        assert!(arg0.type_name == arg1.type_name, 15);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::join(&mut arg0.inner, destroy(arg1));
        arg0.value = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&arg0.inner);
    }

    public fun keep(arg0: BlizzardStakeNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<BlizzardStakeNFT>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun split(arg0: &mut BlizzardStakeNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BlizzardStakeNFT {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::split(&mut arg0.inner, arg1, arg2);
        arg0.value = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&arg0.inner);
        BlizzardStakeNFT{
            id               : 0x2::object::new(arg2),
            inner            : v0,
            symbol           : arg0.symbol,
            type_name        : arg0.type_name,
            activation_epoch : arg0.activation_epoch,
            value            : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&v0),
        }
    }

    public fun split_and_keep(arg0: &mut BlizzardStakeNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = split(arg0, arg1, arg2);
        keep(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

