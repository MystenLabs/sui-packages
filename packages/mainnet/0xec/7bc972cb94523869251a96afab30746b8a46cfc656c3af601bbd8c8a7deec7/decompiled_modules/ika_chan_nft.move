module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_nft {
    struct IKA_CHAN_NFT has drop {
        dummy_field: bool,
    }

    struct IkaChanNft has store, key {
        id: 0x2::object::UID,
        level: 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::Level,
        attributes: 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::Attributes,
        key_wallet: 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet::KeyWallet,
        metadata: Metadata,
    }

    struct Metadata has drop, store {
        rarity: 0x1::string::String,
        edition: 0x1::string::String,
        cover_image: 0x1::string::String,
        foil_pattern: 0x1::string::String,
        background: 0x1::string::String,
        quality: 0x1::string::String,
        hash: 0x1::string::String,
        level: u32,
        evolution_stage: u8,
        key_balance: u64,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : IkaChanNft {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::new(1);
        let v1 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet::new_key_wallet();
        let v2 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::new(arg0, arg1, arg2, arg3, &v0);
        IkaChanNft{
            id         : 0x2::object::new(arg4),
            level      : v0,
            attributes : v2,
            key_wallet : v1,
            metadata   : create_new_metadata(&v2, &v0, &v1),
        }
    }

    public(friend) fun add_keys_to_wallet(arg0: &mut IkaChanNft, arg1: u64) {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet::increase_key_balance(&mut arg0.key_wallet, arg1);
        update_metadata(arg0);
    }

    public fun borrow_attributes(arg0: &IkaChanNft) : &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::Attributes {
        &arg0.attributes
    }

    public fun borrow_level(arg0: &IkaChanNft) : &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::Level {
        &arg0.level
    }

    fun create_new_metadata(arg0: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::Attributes, arg1: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::Level, arg2: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet::KeyWallet) : Metadata {
        Metadata{
            rarity          : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::rarity(arg0),
            edition         : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::edition(arg0),
            cover_image     : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::cover_image(arg0),
            foil_pattern    : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::foil_pattern(arg0),
            background      : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::background(arg0),
            quality         : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::quality(arg0),
            hash            : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::hash(arg0),
            level           : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::current(arg1),
            evolution_stage : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::evolution_stage(arg1),
            key_balance     : 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet::balance(arg2),
        }
    }

    public fun id(arg0: &IkaChanNft) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: IKA_CHAN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"cover_image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"foil_pattern"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"quality"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"hash"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"evolution_stage"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"key_balance"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ika-chan #{metadata.edition}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ika-sama's forbidden tentacle harem. Slimy yet satisfying. Yamete kudasai~!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::values::get_image_url(0x1::string::utf8(b"/images/{metadata.hash}.webp")));
        0x1::vector::push_back<0x1::string::String>(v3, 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::values::display_creator_value());
        0x1::vector::push_back<0x1::string::String>(v3, 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::values::display_project_url());
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.edition}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.rarity}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.cover_image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.foil_pattern}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.background}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.quality}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata.evolution_stage}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{key_wallet.balance}"));
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_asset::init_state<IKA_CHAN_NFT, IkaChanNft>(arg0, v0, v2, 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::values::royalty_bps(), arg1);
    }

    public(friend) fun level_up(arg0: &mut IkaChanNft, arg1: u32) {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::increase_current_level(&mut arg0.level, arg1);
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes::update_dynamic_values(&mut arg0.attributes, &arg0.level);
        update_metadata(arg0);
    }

    public fun metadata(arg0: &IkaChanNft) : &Metadata {
        &arg0.metadata
    }

    public fun metadata_background(arg0: &Metadata) : &0x1::string::String {
        &arg0.background
    }

    public fun metadata_cover_image(arg0: &Metadata) : &0x1::string::String {
        &arg0.cover_image
    }

    public fun metadata_edition(arg0: &Metadata) : &0x1::string::String {
        &arg0.edition
    }

    public fun metadata_evolution_stage(arg0: &Metadata) : u8 {
        arg0.evolution_stage
    }

    public fun metadata_foil_pattern(arg0: &Metadata) : &0x1::string::String {
        &arg0.foil_pattern
    }

    public fun metadata_hash(arg0: &Metadata) : &0x1::string::String {
        &arg0.hash
    }

    public fun metadata_key_balance(arg0: &Metadata) : u64 {
        arg0.key_balance
    }

    public fun metadata_level(arg0: &Metadata) : u32 {
        arg0.level
    }

    public fun metadata_quality(arg0: &Metadata) : &0x1::string::String {
        &arg0.quality
    }

    public fun metadata_rarity(arg0: &Metadata) : &0x1::string::String {
        &arg0.rarity
    }

    public fun mint_keys_from_key_wallet(arg0: &mut IkaChanNft, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::squid_key::SquidKey>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet::mint_keys_from_balance(&mut arg0.key_wallet, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun update_hash_in_metadata(arg0: &mut IkaChanNft, arg1: 0x1::string::String) {
        update_metadata(arg0);
        arg0.metadata.hash = arg1;
    }

    fun update_metadata(arg0: &mut IkaChanNft) {
        arg0.metadata = create_new_metadata(&arg0.attributes, &arg0.level, &arg0.key_wallet);
    }

    // decompiled from Move bytecode v6
}

