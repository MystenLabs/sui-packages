module 0xeb0c5d96948d63f64c87cc4a0d34911c860bd7f5671fd38ba4f12f4cc9dd02b4::athlete_nft {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Tradeable Athlete NFT"));
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
    }

    public fun mint_athlete_nft(arg0: &MintConfig, arg1: 0x77bb2743cb4ef07afded6676a8a05c6c9e133ba30150cefcca3a5546e2dc2992::blueprint::Blueprint, arg2: 0x1::string::String, arg3: u64, arg4: 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::AthleteSbt, arg5: address, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: u64, arg10: vector<u8>, arg11: &0x2::transfer_policy::TransferPolicy<AthleteNft>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_identifier(&arg4);
        let v1 = 0x2::object::id<0x77bb2743cb4ef07afded6676a8a05c6c9e133ba30150cefcca3a5546e2dc2992::blueprint::Blueprint>(&arg1);
        let v2 = 0x2::object::id<0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::AthleteSbt>(&arg4);
        assert!(0x2::clock::timestamp_ms(arg12) <= arg9, 3);
        assert!(arg9 <= 0x2::clock::timestamp_ms(arg12) + 300000, 7);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<AthleteNft>>(arg11) == arg0.policy_id, 5);
        assert!(arg6 == 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_image_url(&arg4), 4);
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<address>(&arg5));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x1::string::String>(&arg6));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x1::string::String>(&arg7));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg8));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&arg9));
        assert!(0x2::ed25519::ed25519_verify(&arg10, &arg0.public_key, &v3), 2);
        mint_athlete_nft_inner(arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg11, arg13);
    }

    fun mint_athlete_nft_inner(arg0: 0x77bb2743cb4ef07afded6676a8a05c6c9e133ba30150cefcca3a5546e2dc2992::blueprint::Blueprint, arg1: 0x1::string::String, arg2: u64, arg3: 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::AthleteSbt, arg4: address, arg5: 0x1::string::String, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg7: &0x2::transfer_policy::TransferPolicy<AthleteNft>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = AthleteNft{
            id            : 0x2::object::new(arg8),
            identifier    : 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_identifier(&arg3),
            name          : 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_name(&arg3),
            country       : 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_country(&arg3),
            edition       : arg1,
            serial_number : arg2,
            image_url     : 0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::get_image_url(&arg3),
            metadata_url  : arg5,
            attributes    : arg6,
            version       : 0,
        };
        0x856629aad57fac9490511f229a25e5c6b9f6ae49b76bf45582b165b271f7f514::athlete_sbt::burn_athlete_sbt(arg3);
        0x77bb2743cb4ef07afded6676a8a05c6c9e133ba30150cefcca3a5546e2dc2992::blueprint::burn(arg0);
        let (v1, v2) = 0x2::kiosk::new(arg8);
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
            recipient     : arg4,
            kiosk_id      : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v4)),
            kiosk_cap_id  : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
        };
        0x2::event::emit<AthleteNftMintEvent>(v5);
        0x2::kiosk::lock<AthleteNft>(&mut v4, &v3, arg7, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg4);
    }

    public fun set_mint_public_key(arg0: &0xf137a9af0d71238fc7db25daef2fedaef2c4793842066ad2389b9454f8bccb60::admin::AdminCap, arg1: &mut MintConfig, arg2: vector<u8>) {
        arg1.public_key = arg2;
        let v0 = MintPublicKeyChangedEvent{
            config_id  : 0x2::object::id<MintConfig>(arg1),
            public_key : arg2,
        };
        0x2::event::emit<MintPublicKeyChangedEvent>(v0);
    }

    public fun set_transfer_policy_id(arg0: &0xf137a9af0d71238fc7db25daef2fedaef2c4793842066ad2389b9454f8bccb60::admin::AdminCap, arg1: &mut MintConfig, arg2: 0x2::object::ID) {
        arg1.policy_id = arg2;
        let v0 = TransferPolicyIdSetEvent{
            config_id : 0x2::object::id<MintConfig>(arg1),
            policy_id : arg2,
        };
        0x2::event::emit<TransferPolicyIdSetEvent>(v0);
    }

    public fun update_athlete_nft(arg0: &MintConfig, arg1: &mut AthleteNft, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg8) <= arg6, 3);
        assert!(arg6 <= 0x2::clock::timestamp_ms(arg8) + 300000, 7);
        assert!(arg2 == arg1.version, 6);
        let v0 = b"";
        let v1 = 0x2::object::id<AthleteNft>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1.identifier));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.public_key, &v0), 2);
        arg1.image_url = arg3;
        arg1.metadata_url = arg4;
        arg1.attributes = arg5;
        arg1.version = arg1.version + 1;
        let v2 = AthleteNftUpdateEvent{
            id           : 0x2::object::id<AthleteNft>(arg1),
            identifier   : arg1.identifier,
            image_url    : arg1.image_url,
            metadata_url : arg1.metadata_url,
            attributes   : arg1.attributes,
            version      : arg1.version,
        };
        0x2::event::emit<AthleteNftUpdateEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

