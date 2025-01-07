module 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::BUDDIES {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        metadata: 0x1::string::String,
        creator: address,
    }

    struct BUDDIES has drop {
        dummy_field: bool,
    }

    fun general_mint(arg0: &mut 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getMetaDataUri(arg0);
        let v1 = 0x1::string::length(&v0);
        let v2 = 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getMinted(arg0) + 1;
        assert!(v2 <= 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getCollectionSupply(arg0), 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::err::supply_maxed_out());
        let v3 = 0x1::string::sub_string(&v0, 0, v1);
        let v4 = *0x1::string::bytes(&v3);
        0x1::vector::append<u8>(&mut v4, b"/");
        let v5 = to_string(v2);
        0x1::vector::append<u8>(&mut v4, *0x1::string::bytes(&v5));
        0x1::vector::append<u8>(&mut v4, b".json");
        let v6 = 0x1::string::sub_string(&v0, 0, v1);
        let v7 = *0x1::string::bytes(&v6);
        0x1::vector::append<u8>(&mut v7, b"/");
        let v8 = to_string(v2);
        0x1::vector::append<u8>(&mut v7, *0x1::string::bytes(&v8));
        0x1::vector::append<u8>(&mut v7, b".JPG");
        let v9 = 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getCollectionName(arg0);
        let v10 = *0x1::string::bytes(&v9);
        0x1::vector::append<u8>(&mut v10, b" #");
        let v11 = to_string(v2);
        0x1::vector::append<u8>(&mut v10, *0x1::string::bytes(&v11));
        let v12 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(v10),
            description : 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getCollectionDescription(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(v7),
            metadata    : 0x1::string::utf8(v4),
            creator     : 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getCreator(arg0),
        };
        0x2::transfer::transfer<NFT>(v12, 0x2::tx_context::sender(arg1));
        0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::inscreaseMinted(arg0);
    }

    fun init(arg0: BUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://twitter.com/suisafari"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<BUDDIES>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun public_mint(arg0: &mut 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getPublicPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::err::coin_amount_below_price());
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getPublicPrice(arg0) * 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getLaunchpadFee(arg0) / 100, arg2), 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    public fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun whitelist_mint(arg0: &mut 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getWhiteListPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::err::coin_amount_below_price());
            let v0 = vector[@0xcb04f4446a4a8008b82f6e5be271b6f8d8953daf78af7b25e8b94e23dc4a2709, @0xef273d896f0def2c88bf55f8d5e8b46b14d8950aa15aa103c39ca3c50b758892, @0x81698525dda18f59ea81a992051a0d2c35c6537eca6e9dc8859efe34a84f5220, @0x6f45226d891e622ba4a0a6cf22a0bfbde6027618eaf448cda696f91bb10f6713, @0xd10d231a9710093eed1f7f6579285402e2f093cc917b43acd7c48f49c77b8d74, @0x28e86d25da4b8010d03e4fc94a31114c60003451cf48f2abe66120f53190575a, @0x3d7cad3b00254652e30ad7bee9fd8fb7cf3ed1129be846e532168e84571c8fcd, @0x1493c9971cac6977e548c131fc875d110f5678cfe5b63b9f72edcf5332daa347, @0xe14a80d03e90cfd34edf5f8372e2f9b46eb0ae62833c2c680336fe265c9f9289, @0xe14a80d03e90cfd34edf5f8372e2f9b46eb0ae62833c2c680336fe265c9f9289, @0xe14a80d03e90cfd34edf5f8372e2f9b46eb0ae62833c2c680336fe265c9f9289, @0xdc3cdb95a46b2eba8345ea1c82b89f89e283dba442a3868cfbb4168c8f132f7a, @0x4a459cb2ef87240dd0da516cd63f2b7125269f19ab573de648e3d6f9bf621973, @0x4ce7689a6461926effbb3b2353c3694a334ec66106c203c1ad92720de848b157, @0x23289b390509ae89256e5f5ae379cfffce3abb7f2f5c41b3409c86c7933e6350, @0xf618fda3ee253b38331b5520903a7d56b1f9a3c6a3d83db51d89d5a7b25bc960, @0x2f6a903ab9994ea6c5fc9b0627d1d00d7bdbc8c45fcceca31eb60d1a6148a097, @0x59d14ed737a4380337e33373bd2bf32ebe33552bd0e010d42d663febd7d10b59, @0xbf75e6c2ea0c595dbd78f4edfd64b82351d3b90f8d1ae007a70f1e29c45fd9f5, @0x99e4edb69396531441cf4c757f463f5245d74b205e5f0c2630c4ca749e101d24, @0x3eb9e464752d9a536e8ada5db369b8b2ae47fd2c8395c0385935f6647240c482, @0x2bdf86af06446cfc4032a7d8e662b91898f24aa03af7e5a6ff7b2ec401841446, @0xa7a594a02ac557ef263c22537a0f8ac6ebf4f3f2e6bed6396450252222568f3e, @0xa7a594a02ac557ef263c22537a0f8ac6ebf4f3f2e6bed6396450252222568f3e, @0x75f1ae1a821bb8fba1d7b8d309bd0ffc42b08ccf19177ece2d0964ec422c40ed, @0xe5452a948de4736e1cfca759222e315e3dc2e7cdaed75d5929276a535f4e7ad3, @0x3356ab30131e83d1a19e8c7b49029c950ca371b98c8b94f5284475dca0e3f46f, @0xbe367c0373ced56b36f06578658dd220f3d49599a0eb59832ac697e9521a53bf, @0x21218c9b29b6b3935003f217ae5a783d22db0da6d8ecb232384ebb87b4bc361c, @0x9e8158a2709751892a5afc530f2312b1e945cbd3311626668c54b6e985634ae7, @0x5543a8243f8539b0b79ac4b41937204e65e903e2b80d69d0358cee9e5bbeda5a, @0x395e86bbc8d2bdec1514c95938f6ff992c85d5c7d2a55a0bb3f3182d41de5a5c, @0x49f6a2a468b719402753436629cc149ebb3a072fb1fc26b3e5517128b4a4e57d, @0x7b322bdd5554b1c7b3cd2a7315db858ea7f1480f0bdae0f44fcabac819cbfa87, @0xbd47872a81431f824cf2edea917bb5ac97994946faf8f51edf9ec44b98161d63, @0x71bb7f8d55ec74259f84bbd2a455ce8db18606d443370d8b1ab221c735b3dd1d, @0xd9de5d5487f3a27a3bdf4f5b0e57f471816a65885f7525fc3a5fb1895049f067, @0x2fea58fb5ca6959f8ea63636ea8f5ad691a988401dd589c864e537fccb634ef7, @0x4122b41feb800703a8588571391785b6cca28469b82d5608766c28ef9d490432, @0xb00776df22f587c5ed7539ccec85f86129f3aa760ffded4686f0336a3b24211d, @0xc8b2d46e4b8d343e935df78f4df6c68ab40ca7fd5352a462802f73f6b908239, @0x7eaa0fe658fbde9fe6d1dda71206a04c3c1953ce73b10740305845ae0e5aa6d4, @0x72528ce9fa694bd6b3ebae05a2bc6c47cf34fafa53bd8b06c67428afdb4ebbed, @0x9c0afafb57856a1edd2b2c75be87b9d8848eb662aa2c1bff6e48743537a301d4, @0x943e374115c63f65f6daab1e5c60d64d6e2051f4f42226e14597785abeb46d97, @0x34503ca78689731af8bc9c1e3977fe49a2778ce67ebc96f50a3bae32ed71313b, @0x6954d7dfd8f6260d4e34de3db6ecf0838c85ffc80dba1ae355d26c0dd8392eab];
            let v1 = 0x2::tx_context::sender(arg2);
            assert!(0x1::vector::contains<address>(&v0, &v1), 0);
            0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::addWhitelistAddress(arg0, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getWhiteListPrice(arg0) * 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getLaunchpadFee(arg0) / 100, arg2), 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf3497547c30a369a0751b7dbf98b7ce5c94d94e909c2766049872e7bf5b6b373::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

