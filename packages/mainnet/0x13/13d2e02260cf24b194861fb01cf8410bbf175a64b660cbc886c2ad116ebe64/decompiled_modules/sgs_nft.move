module 0x1313d2e02260cf24b194861fb01cf8410bbf175a64b660cbc886c2ad116ebe64::sgs_nft {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct SuiSGSNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct PebbleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct AmbrusE4CNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct SuperBNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct LumiwaveNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct WarpedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct CrossmintNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct BeamableNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct TeamLiquidNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct UppticNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct XocietyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct OneChampionshipNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct MintSuiSGSNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintPebbleNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintAmbrusE4CNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintSuperBNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintLumiwaveNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintWarpedNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintCrossmintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintBeamableNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintTeamLiquidNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintUppticNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintXocietyNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MintOneChampionshipNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct SGS_NFT has drop {
        dummy_field: bool,
    }

    public fun ambrus_nft_fields(arg0: &AmbrusE4CNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun beamable_nft_fields(arg0: &BeamableNFT) : &0x1::string::String {
        &arg0.name
    }

    fun create_ambrus_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"E4C: Final Salvation is a Web3 gaming metaverse set in the near future."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/Qmcv5rg7dNYNQ17bdnVwD4ph4yJmVRbKg8vs9vXUJTQBSb"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmTREj2J3as7nMk5Y1NyqfyaofhBEA9xD24Bca1temWtqM"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ambrus E4C Gaming"));
        let v4 = 0x2::display::new_with_fields<AmbrusE4CNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<AmbrusE4CNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<AmbrusE4CNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_beamable_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"5468616e6b20796f7520666f72206a6f696e696e6720757320617420746865205375692047616d696e672053756d6d6974203230323520616e6420737570706f7274696e672067616d6520646576656c6f70657273206f6e204265616d61626c6520616e6420537569210a0a2042696f3a204265616d61626c652068656c70732067616d6520646576656c6f70657273206275696c64206120636f6d70726568656e73697665206261636b656e642c20696e74656772617465205375692c20616e64207368697020666173746572207769746820706f77657266756c20776f726b666c6f7720616e642053444b7320666f7220556e69747920616e6420556e7265616c2e205369676e20757020666f7220667265652061742068747470733a2f2f6265616d61626c652e636f6d"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmX6hirz2kUHyeo6Upd1QaS1oe3B16Gy1xC2Bq43HNWE26"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmNfbK2Gw5rgsyzWLe8Pmk7vAfQptRQJNfn5j1xF4sJesZ"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Beamable Gaming"));
        let v4 = 0x2::display::new_with_fields<BeamableNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BeamableNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<BeamableNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_crossmint_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"We're delighted to present you with a commemorative NFT for joining Crossmint and Sui at the Sui Gaming summit. Show this NFT to any Crossmint team member to get preferred pricing when building your Sui game."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmTyktMMDUhFjC5mmHXwca2S73ZUs24Pker1fhuunGbpsL"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmPRjfcEAvkxTbK83EA2jzu9kHRMZ6d2MS2XvztGJz9bYx"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Crossmint Gaming"));
        let v4 = 0x2::display::new_with_fields<CrossmintNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<CrossmintNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<CrossmintNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_lumiwave_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"41726520796f7520726561647920746f207374657020696e746f2061206e65772065726120776974682053616d757261692053686f646f776e20522c20776865726520556b796f277320756e7368616b656e207265736f6c766520616e642072617a6f722d736861727020626c61646520637574207468726f756768206661746520697473656c66e280946e6f7720697320796f7572206368616e636520746f206f776e20686973206c6567656e64617279204961696a75747375"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmaVnFGySgouD5BpfTKXdHex2S77nkHyds7TA3wHxfcGbC"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmbB3CufFA59jGmY8HLCvv1YcjSPwpyaQFtFkA9KSLLbvM"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lumiwave Gaming"));
        let v4 = 0x2::display::new_with_fields<LumiwaveNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<LumiwaveNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<LumiwaveNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_onechampionship_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ONE Fight Arena Badge is an exclusive NFT collection represents the innovative fan engagement gaming ecosystem - ONE Fight Arena. Each badge is a symbol of honor and resilience, introducing fans the unique way to connect with the ONE Fight Arena community. Join us here and experience the power of Adrenaline: https://www.onefightarena.com/quests"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmVZy2cqMjK9bqNcgVo7o9pV3zXvFBtXZrnho63tJCAQZX"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmPLyGMz56VbyywkdFphNPUv2c3CpsPb8Am1BMjnP25voB"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ONE Championship Gaming"));
        let v4 = 0x2::display::new_with_fields<OneChampionshipNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<OneChampionshipNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<OneChampionshipNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_pebble_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"STARBLE is the utility token of the Pebble ecosystem. More STARBLE means more thrilling opportunities to enjoy Pebble City, the next-gen web3 social casino game."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmZwZVpfYfkG3JKaeuJwxVkY2gPycG1pojSw6codfzNY5C"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmNyuzopgAAGmZo2NchmgM2X7H8pSibLywq6JpcjKDDkbC"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Pebble Gaming"));
        let v4 = 0x2::display::new_with_fields<PebbleNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<PebbleNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<PebbleNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_sui_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"417320612076697375616c206172746973742c206d7920776f726b2061696d7320746f207472616e736c617465207069766f74616c206d6f6d656e747320696e20706f702063756c7475726520696e746f20656e647572696e67206469676974616c20617274656661637473206f7220617320492063616c6c207468656d206e6f6e2d66756e6769626c6520746f79732e204d792063686f73656e206d656469756d20666f7220616368696576696e67207468697320697320546f792046616365732c206120636f6c6c656374696f6e206f6620706f727472616974732074686174206172652072656d696e697363656e74206f66206368696c64686f6f6420746f797320616e642065766f6b65206665656c696e6773206f66206e6f7374616c67696120616e6420636f6d666f72742e0a0a4561636820546f792046616365206973206361726566756c6c79206372616674656420746f206361707475726520746865207375626a656374277320756e697175652066656174757265732c20706572736f6e616c6974792c20616e64207370697269742e204920706179207370656369616c20617474656e74696f6e20746f2074686520636f6c6f727320616e64207061747465726e73206f6e206561636820706f7274726169742c207573696e67207468656d20746f20656e68616e63652074686520746f792d6c696b65206165737468657469632e0a0a4d7920696e737069726174696f6e20666f7220546f7920466163657320636f6d65732066726f6d206d79206f776e206c6f7665206f6620746f797320616e6420746865206d656d6f726965732074686579206272696e672e20492062656c69657665207468617420746f797320686176652061207370656369616c206162696c69747920746f207472616e73706f7274207573206261636b20746f20612074696d65207768656e206c696665207761732073696d706c657220616e642066756c6c206f6620776f6e6465722e2057697468206561636820546f7920466163652c204920686f706520746f2074617020696e746f20746861742073656e7365206f66206368696c646c696b6520637572696f7369747920616e6420637265617465206120636f6e6e656374696f6e206265747765656e207468652076696577657220616e6420746865207375626a6563742e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmYQhp55PXR3KXaketUermbkWTNgcGD4GmJzogAP9UGKGr"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmNgHvrdzawSbYdmrrSZP9JovmgW7R1FhmX6A6PMVsReok"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Gaming"));
        let v4 = 0x2::display::new_with_fields<SuiSGSNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<SuiSGSNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<SuiSGSNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_superb_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"4265616e792c2074686520636865657266756c206769726c20696e20612079656c6c6f77207261696e636f61742c2064616e6365732068617070696c7920616c6f6e6773696465207468652057617465722044726f7020426f74210a0a54686973206578636c7573697665204e4654206973206f6e6c7920617661696c61626c6520666f72206d696e74696e6720617420746865205375692047616d696e672053756d6d6974210a0a4556454e5420434f4445203a205355495f5355504552425f474443323032355f4556454e545f4954454d"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmU9V2tEXKFfFxAHA4kZmzmrm18D7fyVmAqKHjzDCHGsCN"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmNheQp2MKEXpYJYiYgWA7Bg5vE1sgxZ137nUzfSmD7MhU"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuperB Gaming"));
        let v4 = 0x2::display::new_with_fields<SuperBNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<SuperBNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<SuperBNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_teamliquid_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Team Liquid's mascot Blue visits the Sui Gaming Summit 2025 in San Francisco! Exclusively claimed by event attendees."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmbJjHupkYhb6uugDaPhayc8PCenf66xeS8F6bvgZVbYG9"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmXwphNPPsCDU2G4hRtCuNedpaPRGt7NvoosC4Kqqt3TTy"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Team Liquid Gaming"));
        let v4 = 0x2::display::new_with_fields<TeamLiquidNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<TeamLiquidNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<TeamLiquidNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_upptic_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"556e6c6f636b20796f75722067616d65277320706f74656e7469616c2077697468205570707469632c20796f75722067616d6527732067726f777468207465616d2e0a0a205570707469632068656c70732074686520776f726c64277320626573742067616d65207465616d732067726f77207769746820616c6c2074686520746f6f6c7320616e6420736572766963657320796f75206e65656420746f207265616368206d696c6c696f6e73206f6620676c6f62616c20706c61796572732e0a0a205573652074686973204e465420746f206765742024314b206f666620616e79205570707469632073657276696365207061636b61676520666f7220746865206669727374206d6f6e746821"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/Qmab4Xew67QFYFKkvPw8fAKeaCe3EaH1yAcwBpn5WQaK7u"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmY8ohLKH2vzu2wiJh7sD56hdx6P36euJDu5396BnFnTMD"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Upptic Gaming"));
        let v4 = 0x2::display::new_with_fields<UppticNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<UppticNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<UppticNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_warped_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A still mind, encased in utmost security, is a bastion for the relentless drive to build beyond."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmRnk4XsDPxhG3MJkS8YtMKqDGNjdPyBYZkb9RZgs8EjJz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmTiXxrGjc9mXRH98CbW3iJtodYGU75azchrh86bfKrM6R"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Warped Gaming"));
        let v4 = 0x2::display::new_with_fields<WarpedNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<WarpedNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<WarpedNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun create_xociety_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"584f4349455459206973206120504f502053686f6f7465722077697468205250472070726f6772657373696f6e2c206261636b6564206279204841534845442c205375692c205370617274616e20616e64204b524146544f4e2e200a2053657420696e20612064656570205363692d466920776f726c642e20584f43494554592061696d7320746f207265646566696e652067616d696e6720657870657269656e636573206f66666572696e6720706c61796572732065636f6e6f6d696320636f6e74726f6c2c20616e64207472616e73666f726d696e67207468656d20696e746f206b6579206465636973696f6e2d6d616b6572732e20556e6c696b6520747261646974696f6e616c203372642d706572736f6e2073686f6f7465722067616d65732c20776865726520612073696e676c652075736572277320616374697669747920686173206c6974746c6520696d70616374206f6e207468652062726f616465722067616d6520656e7669726f6e6d656e742c206465636973696f6e7320696e20584f4349455459206372656174652064796e616d696320726970706c652065666665637473207468726f7567686f7574207468652067616d65706c617920616e6420656e7669726f6e6d656e742e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/QmTuwkaZ5wCuPDtzCbLpxWzHv9M8sDvoEx23pRHMnVpDfS"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs-gateway.gifted.art/ipfs/Qma87w5jUV9zFyZbAuyopqCLvXJ1cqbpLkyMq2M1xCf43Q"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suigamingsummit.splashthat.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"XOCIETY Gaming"));
        let v4 = 0x2::display::new_with_fields<XocietyNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<XocietyNFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<XocietyNFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun crossmint_nft_fields(arg0: &CrossmintNFT) : &0x1::string::String {
        &arg0.name
    }

    fun generate_nft_name(arg0: 0x1::string::String, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        let v1 = 0x1::vector::empty<u8>();
        if (arg1 == 0) {
            0x1::vector::push_back<u8>(&mut v1, 48);
        };
        while (arg1 > 0) {
            0x1::vector::push_back<u8>(&mut v1, ((arg1 % 10) as u8) + 48);
            arg1 = arg1 / 10;
        };
        let v2 = 0;
        let v3 = 0x1::vector::length<u8>(&v1);
        while (v2 < v3 / 2) {
            *0x1::vector::borrow_mut<u8>(&mut v1, v2) = *0x1::vector::borrow<u8>(&v1, v3 - v2 - 1);
            *0x1::vector::borrow_mut<u8>(&mut v1, v3 - v2 - 1) = *0x1::vector::borrow<u8>(&v1, v2);
            v2 = v2 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(v1));
        v0
    }

    fun init(arg0: SGS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SGS_NFT>(arg0, arg1);
        create_sui_display(&v0, arg1);
        create_pebble_display(&v0, arg1);
        create_ambrus_display(&v0, arg1);
        create_superb_display(&v0, arg1);
        create_lumiwave_display(&v0, arg1);
        create_warped_display(&v0, arg1);
        create_crossmint_display(&v0, arg1);
        create_beamable_display(&v0, arg1);
        create_teamliquid_display(&v0, arg1);
        create_upptic_display(&v0, arg1);
        create_xociety_display(&v0, arg1);
        create_onechampionship_display(&v0, arg1);
        let v1 = AdminCap{
            id      : 0x2::object::new(arg1),
            counter : 0,
        };
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun lumiwave_nft_fields(arg0: &LumiwaveNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun mint_all_nfts(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) : (SuiSGSNFT, PebbleNFT, AmbrusE4CNFT, SuperBNFT, LumiwaveNFT, WarpedNFT, CrossmintNFT, BeamableNFT, TeamLiquidNFT, UppticNFT, XocietyNFT, OneChampionshipNFT) {
        arg0.counter = arg0.counter + 1;
        let v0 = arg0.counter;
        let v1 = SuiSGSNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"Sui Gamer Toy Face"), v0),
        };
        let v2 = MintSuiSGSNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v1.name,
        };
        0x2::event::emit<MintSuiSGSNFTEvent>(v2);
        let v3 = PebbleNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"STARBLE"), v0),
        };
        let v4 = MintPebbleNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v3.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v3.name,
        };
        0x2::event::emit<MintPebbleNFTEvent>(v4);
        let v5 = AmbrusE4CNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"E4C: Final Salvation"), v0),
        };
        let v6 = MintAmbrusE4CNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v5.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v5.name,
        };
        0x2::event::emit<MintAmbrusE4CNFTEvent>(v6);
        let v7 = SuperBNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"Beany"), v0),
        };
        let v8 = MintSuperBNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v7.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v7.name,
        };
        0x2::event::emit<MintSuperBNFTEvent>(v8);
        let v9 = LumiwaveNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"Tachibana Ukyo"), v0),
        };
        let v10 = MintLumiwaveNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v9.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v9.name,
        };
        0x2::event::emit<MintLumiwaveNFTEvent>(v10);
        let v11 = WarpedNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"SUI Zen Zero Helmet"), v0),
        };
        let v12 = MintWarpedNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v11.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v11.name,
        };
        0x2::event::emit<MintWarpedNFTEvent>(v12);
        let v13 = CrossmintNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"Crossmint x Sui"), v0),
        };
        let v14 = MintCrossmintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v13.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v13.name,
        };
        0x2::event::emit<MintCrossmintNFTEvent>(v14);
        let v15 = BeamableNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"Beamable + Sui 2025"), v0),
        };
        let v16 = MintBeamableNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v15.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v15.name,
        };
        0x2::event::emit<MintBeamableNFTEvent>(v16);
        let v17 = TeamLiquidNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"TL Blue + Sui Gaming Summit 2025"), v0),
        };
        let v18 = MintTeamLiquidNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v17.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v17.name,
        };
        0x2::event::emit<MintTeamLiquidNFTEvent>(v18);
        let v19 = UppticNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"Upptic x Sui Summit & GDC 2025"), v0),
        };
        let v20 = MintUppticNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v19.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v19.name,
        };
        0x2::event::emit<MintUppticNFTEvent>(v20);
        let v21 = XocietyNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"XOCIETY GDC SQUAD"), v0),
        };
        let v22 = MintXocietyNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v21.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v21.name,
        };
        0x2::event::emit<MintXocietyNFTEvent>(v22);
        let v23 = OneChampionshipNFT{
            id   : 0x2::object::new(arg1),
            name : generate_nft_name(0x1::string::utf8(b"ONE Fight Arena Badge"), v0),
        };
        let v24 = MintOneChampionshipNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v23.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v23.name,
        };
        0x2::event::emit<MintOneChampionshipNFTEvent>(v24);
        (v1, v3, v5, v7, v9, v11, v13, v15, v17, v19, v21, v23)
    }

    public entry fun mint_all_nfts_to_recipient(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = mint_all_nfts(arg0, arg2);
        0x2::transfer::public_transfer<SuiSGSNFT>(v0, arg1);
        0x2::transfer::public_transfer<PebbleNFT>(v1, arg1);
        0x2::transfer::public_transfer<AmbrusE4CNFT>(v2, arg1);
        0x2::transfer::public_transfer<SuperBNFT>(v3, arg1);
        0x2::transfer::public_transfer<LumiwaveNFT>(v4, arg1);
        0x2::transfer::public_transfer<WarpedNFT>(v5, arg1);
        0x2::transfer::public_transfer<CrossmintNFT>(v6, arg1);
        0x2::transfer::public_transfer<BeamableNFT>(v7, arg1);
        0x2::transfer::public_transfer<TeamLiquidNFT>(v8, arg1);
        0x2::transfer::public_transfer<UppticNFT>(v9, arg1);
        0x2::transfer::public_transfer<XocietyNFT>(v10, arg1);
        0x2::transfer::public_transfer<OneChampionshipNFT>(v11, arg1);
    }

    public fun onechampionship_nft_fields(arg0: &OneChampionshipNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun pebble_nft_fields(arg0: &PebbleNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun sui_nft_fields(arg0: &SuiSGSNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun superb_nft_fields(arg0: &SuperBNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun teamliquid_nft_fields(arg0: &TeamLiquidNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun upptic_nft_fields(arg0: &UppticNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun warped_nft_fields(arg0: &WarpedNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun xociety_nft_fields(arg0: &XocietyNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

