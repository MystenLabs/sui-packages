module 0x9738544f38b9ce077a0789598916188b5541f81493cc7b52a7b2adc1be7c97eb::athlete_nft {
    struct VersionConfig has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        previous_version: u64,
        new_version: u64,
    }

    struct ATHLETE_NFT has drop {
        dummy_field: bool,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        policy_id: 0x2::object::ID,
    }

    struct AthleteNft has store, key {
        id: 0x2::object::UID,
        identifier: u64,
        name: 0x1::string::String,
        country: 0x1::string::String,
        edition: 0x1::string::String,
        serial_number: u64,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        version: u64,
    }

    struct AthleteNftMintEvent has copy, drop {
        id: 0x2::object::ID,
        identifier: u64,
        name: 0x1::string::String,
        country: 0x1::string::String,
        edition: 0x1::string::String,
        serial_number: u64,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        recipient: address,
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
    }

    struct AthleteNftUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        identifier: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        version: u64,
    }

    struct MintPublicKeyChangedEvent has copy, drop {
        config_id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct TransferPolicyIdSetEvent has copy, drop {
        config_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
    }

    public fun get_country(arg0: &AthleteNft) : 0x1::string::String {
        arg0.country
    }

    public fun get_identifier(arg0: &AthleteNft) : u64 {
        arg0.identifier
    }

    public fun get_image_url(arg0: &AthleteNft) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_name(arg0: &AthleteNft) : 0x1::string::String {
        arg0.name
    }

    fun assert_version(arg0: &VersionConfig) {
        assert!(arg0.version == 1, 101);
    }

    public fun get_attributes(arg0: &AthleteNft) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun get_metadata_url(arg0: &AthleteNft) : 0x1::string::String {
        arg0.metadata_url
    }

    public fun get_serial_number(arg0: &AthleteNft) : u64 {
        arg0.serial_number
    }

    public fun get_version(arg0: &AthleteNft) : u64 {
        arg0.version
    }

    fun init(arg0: ATHLETE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"country"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"metadata_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{country}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{edition}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"4f574e20594f555220464947485445522e2046494748542e204541524e2e2054524144452e0a0a4f4e45204669676874204172656e61206973206120746163746963616c204d4d41205076502067616d6520666f7220694f5320616e6420416e64726f696420776865726520796f75722066696768746572732063616e206265636f6d65207472616461626c65204e465473206f6e205375692e2043726561746520616e6420637573746f6d697a6520796f7572206f776e206174686c6574652c206275696c64207468656972206361726565722c20757067726164652074686569722073746174732c206765617220616e64206162696c69746965732c20616e64207472756c79206f776e20746865206669676874657220796f7527766520646576656c6f7065642e0a0a5472616465206669676874657273206f6e205472616465506f72742c206272696e6720707572636861736564206174686c65746573206469726563746c7920696e746f20796f757220696e2d67616d652047796d2c20636f6d7065746520616761696e7374206f7468657220706c617965727320616e6420666967687420666f722053554920726577617264732e20596f752063616e20616c736f207374657020696e746f2074686520636167652077697468206f6666696369616c204f4e45204368616d70696f6e736869702073746172732e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://onefightarena.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::package::claim<ATHLETE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AthleteNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<AthleteNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AthleteNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MintConfig{
            id         : 0x2::object::new(arg1),
            public_key : b"",
            policy_id  : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<MintConfig>(v6);
        let v7 = VersionConfig{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<VersionConfig>(v7);
    }

    entry fun migrate_version(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig) {
        migrate_version_to(arg0, arg1, 1);
    }

    fun migrate_version_to(arg0: &0x2::package::Publisher, arg1: &mut VersionConfig, arg2: u64) {
        assert!(0x2::package::from_module<ATHLETE_NFT>(arg0), 100);
        assert!(arg1.version < arg2, 102);
        arg1.version = arg2;
        let v0 = VersionUpdatedEvent{
            config_id        : 0x2::object::id<VersionConfig>(arg1),
            previous_version : arg1.version,
            new_version      : arg2,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
    }

    public fun mint_athlete_nft(arg0: &VersionConfig, arg1: &0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::VersionConfig, arg2: &0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint::VersionConfig, arg3: &MintConfig, arg4: 0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint::Blueprint, arg5: 0x1::string::String, arg6: u64, arg7: 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::AthleteSbt, arg8: address, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg12: u64, arg13: vector<u8>, arg14: &0x2::transfer_policy::TransferPolicy<AthleteNft>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::get_identifier(&arg7);
        let v1 = 0x2::object::id<0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint::Blueprint>(&arg4);
        let v2 = 0x2::object::id<0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::AthleteSbt>(&arg7);
        assert!(0x2::clock::timestamp_ms(arg15) <= arg12, 3);
        assert!(arg12 <= 0x2::clock::timestamp_ms(arg15) + 300000, 7);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<AthleteNft>>(arg14) == arg3.policy_id, 5);
        assert!(arg9 == 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::get_image_url(&arg7), 4);
        let v3 = b"NOTRE_ATHLETE_NFT_V2_MINT";
        let v4 = 0x2::object::id<MintConfig>(arg3);
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&v4));
        let v5 = 1;
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&v5));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<address>(&arg8));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x1::string::String>(&arg9));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x1::string::String>(&arg10));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg11));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&arg12));
        assert!(0x2::ed25519::ed25519_verify(&arg13, &arg3.public_key, &v3), 2);
        mint_athlete_nft_inner(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg10, arg11, arg14, arg16);
    }

    fun mint_athlete_nft_inner(arg0: &0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::VersionConfig, arg1: &0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint::VersionConfig, arg2: 0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint::Blueprint, arg3: 0x1::string::String, arg4: u64, arg5: 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::AthleteSbt, arg6: address, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: &0x2::transfer_policy::TransferPolicy<AthleteNft>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = AthleteNft{
            id            : 0x2::object::new(arg10),
            identifier    : 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::get_identifier(&arg5),
            name          : 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::get_name(&arg5),
            country       : 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::get_country(&arg5),
            edition       : arg3,
            serial_number : arg4,
            image_url     : 0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::get_image_url(&arg5),
            metadata_url  : arg7,
            attributes    : arg8,
            version       : 0,
        };
        0x35ddf8f4d923385250ab0ded80051c98c3e3f6589521803f3567c30386f057d1::athlete_sbt::burn_athlete_sbt(arg0, arg5);
        0xb1bb34f423b5ebcedaf8d2363a6dadb8628cc6583d70377464b74e4627de1e76::blueprint::burn(arg1, arg2);
        let (v1, v2) = 0x2::kiosk::new(arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = AthleteNftMintEvent{
            id            : 0x2::object::id<AthleteNft>(&v0),
            identifier    : v0.identifier,
            name          : v0.name,
            country       : v0.country,
            edition       : v0.edition,
            serial_number : v0.serial_number,
            image_url     : v0.image_url,
            metadata_url  : v0.metadata_url,
            attributes    : v0.attributes,
            recipient     : arg6,
            kiosk_id      : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v4)),
            kiosk_cap_id  : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
        };
        0x2::event::emit<AthleteNftMintEvent>(v5);
        0x2::kiosk::lock<AthleteNft>(&mut v4, &v3, arg9, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg6);
    }

    public fun set_mint_public_key(arg0: &VersionConfig, arg1: &0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::admin::AdminCap, arg2: &mut MintConfig, arg3: vector<u8>) {
        assert_version(arg0);
        arg2.public_key = arg3;
        let v0 = MintPublicKeyChangedEvent{
            config_id  : 0x2::object::id<MintConfig>(arg2),
            public_key : arg3,
        };
        0x2::event::emit<MintPublicKeyChangedEvent>(v0);
    }

    public fun set_transfer_policy_id(arg0: &VersionConfig, arg1: &0x589e47c212a22d5d468fc42a7a2e19066276898982dab20d3b369382548366d6::admin::AdminCap, arg2: &mut MintConfig, arg3: 0x2::object::ID) {
        assert_version(arg0);
        arg2.policy_id = arg3;
        let v0 = TransferPolicyIdSetEvent{
            config_id : 0x2::object::id<MintConfig>(arg2),
            policy_id : arg3,
        };
        0x2::event::emit<TransferPolicyIdSetEvent>(v0);
    }

    public fun update_athlete_nft(arg0: &VersionConfig, arg1: &MintConfig, arg2: &mut AthleteNft, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg8, 3);
        assert!(arg8 <= 0x2::clock::timestamp_ms(arg10) + 300000, 7);
        assert!(arg3 == arg2.version, 6);
        let v0 = b"NOTRE_ATHLETE_NFT_V2_UPDATE";
        let v1 = 0x2::object::id<MintConfig>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 1;
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
        let v3 = 0x2::object::id<AthleteNft>(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2.identifier));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg8));
        assert!(0x2::ed25519::ed25519_verify(&arg9, &arg1.public_key, &v0), 2);
        arg2.name = arg4;
        arg2.image_url = arg5;
        arg2.metadata_url = arg6;
        arg2.attributes = arg7;
        arg2.version = arg2.version + 1;
        let v4 = AthleteNftUpdateEvent{
            id           : 0x2::object::id<AthleteNft>(arg2),
            identifier   : arg2.identifier,
            name         : arg2.name,
            image_url    : arg2.image_url,
            metadata_url : arg2.metadata_url,
            attributes   : arg2.attributes,
            version      : arg2.version,
        };
        0x2::event::emit<AthleteNftUpdateEvent>(v4);
    }

    public fun version(arg0: &VersionConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

