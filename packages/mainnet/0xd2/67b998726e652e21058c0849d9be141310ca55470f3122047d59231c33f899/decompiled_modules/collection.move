module 0xd267b998726e652e21058c0849d9be141310ca55470f3122047d59231c33f899::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        number: u64,
        serial: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        image_sha256: 0x1::string::String,
        rarity_rank: u64,
        rarity_score: u64,
        rarity_tier: 0x1::string::String,
        collection: 0x1::string::String,
        initial_price_usdt: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct LockedDisplayAuthority has key {
        id: 0x2::object::UID,
        cap: 0x2::display_registry::DisplayCap<NFT>,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        recipient: address,
    }

    public fun configure_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<NFT>(arg0, &mut arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<NFT>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<NFT>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<NFT>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display_registry::set<NFT>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"{collection}"));
        0x2::display_registry::share<NFT>(v3);
        let v4 = LockedDisplayAuthority{
            id  : 0x2::object::new(arg2),
            cap : v2,
        };
        0x2::transfer::freeze_object<LockedDisplayAuthority>(v4);
        0x2::package::burn_publisher(arg1);
    }

    fun create_nft(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x1::string::utf8(arg5);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Edition"), 0x1::string::utf8(b"1/1"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Rarity Tier"), v0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::string::utf8(b"Theme"), 0x1::string::utf8(b"Constancy / Continuity"));
        let v2 = if (arg0 <= 50) {
            arg0
        } else {
            0
        };
        let v3 = if (arg0 <= 50) {
            51 - arg0
        } else {
            100
        };
        let v4 = if (arg0 <= 50) {
            b"CyC Continuity 50"
        } else {
            b"CyC Collector Trio"
        };
        NFT{
            id                 : 0x2::object::new(arg7),
            number             : arg0,
            serial             : 0x1::string::utf8(arg1),
            name               : 0x1::string::utf8(arg2),
            description        : 0x1::string::utf8(b"A unique CyC Mobius artwork exploring continuity and permanence. Rarity is a curated design category. Initial asking price is not a sale or valuation."),
            image_url          : 0x1::string::utf8(arg3),
            image_sha256       : 0x1::string::utf8(arg4),
            rarity_rank        : v2,
            rarity_score       : v3,
            rarity_tier        : v0,
            collection         : 0x1::string::utf8(v4),
            initial_price_usdt : arg6,
            attributes         : v1,
        }
    }

    public fun image_sha256(arg0: &NFT) : &0x1::string::String {
        &arg0.image_sha256
    }

    public fun image_url(arg0: &NFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(true, 0);
        init_collection(arg0, @0xfdc2a064224fa4d4859f7a9ee2e466987d71ba442a075f86b3fd9cf8eee413c1, arg1);
    }

    fun init_collection(arg0: COLLECTION, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COLLECTION>(arg0, arg2), 0x2::tx_context::sender(arg2));
        mint_to_recipient(1, b"001", x"43794320436f6e74696e75697479202330303120e280942047656e65736973204469616d6f6e64", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BAQAPAA", b"e8fd0d99b2da080e20e1fe64009adfbbcd52160fb3d20df8cb93219131070cee", b"Extreme Rare", 10000, arg1, arg2);
        mint_to_recipient(2, b"002", x"43794320436f6e74696e75697479202330303220e280942041657465726e756d", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BDwAfAA", b"676197782e6d7d0307801cce29de45eabb9afb3e9ae479d9af1106793647496d", b"Extreme Rare", 10000, arg1, arg2);
        mint_to_recipient(3, b"003", x"43794320436f6e74696e75697479202330303320e2809420507269736d204865617274", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BHwAsAA", b"17644a45bfd77e61fc0f711bb9005d1c5a3dd2f65156e3ebe82ab3e620b5dd3b", b"Extreme Rare", 10000, arg1, arg2);
        mint_to_recipient(4, b"004", x"43794320436f6e74696e75697479202330303420e28094204f726967696e2041726320e280942043697263756c6172204f70616c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BLAA7AA", b"a5c2a1fc5b09b9d7e1c9d274b4dfd735fb58731777e3b268219c6838b7e105fb", b"Extreme Rare", 10000, arg1, arg2);
        mint_to_recipient(5, b"005", x"43794320436f6e74696e75697479202330303520e2809420496e66696e697465204175726f726120e280942043697263756c617220506561726c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BOwBLAA", b"1756f135a90dcbb68b978244deb7e8a7350b64806c97e6f6e6d5e38741fbdd1d", b"Extreme Rare", 10000, arg1, arg2);
        mint_to_recipient(6, b"006", x"43794320436f6e74696e75697479202330303620e2809420416d657468797374204368726f6e6f73", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BSwBaAA", b"0cd6f738777016e4607e30e34bff86ad35e21fc337a95372e6d9ffaea45666b1", b"Extreme Rare", 120, arg1, arg2);
        mint_to_recipient(7, b"007", x"43794320436f6e74696e75697479202330303720e280942045636c697073652052656c6963", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BWgBnAA", b"ad8c60dd9ece1f59a05b68fbf92a5811397967c589846a3bd1e339d904987f55", b"Extreme Rare", 120, arg1, arg2);
        mint_to_recipient(8, b"008", x"43794320436f6e74696e75697479202330303820e28094204e6562756c61204d657263757279", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BZwB3AA", b"2bd75ac1e0d2b78acffcd23809ed14f00273e2feeabb9cb5bd6b9517aa6c1694", b"Extreme Rare", 120, arg1, arg2);
        mint_to_recipient(9, b"009", x"43794320436f6e74696e75697479202330303920e2809420457465726e616c2046696c6967726565", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BdwCGAA", b"086c322d990c74cfec0b1cb8a7776a1aa2fd15a84c4efdb48847de1807adada4", b"Extreme Rare", 120, arg1, arg2);
        mint_to_recipient(10, b"010", x"43794320436f6e74696e75697479202330313020e2809420436f736d6963205370696e656c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BhgCVAA", b"86f47b4c60293a53daaf6a172df0b722a4d05df9cd77da50e95975797c0867d3", b"Extreme Rare", 120, arg1, arg2);
        mint_to_recipient(11, b"011", x"43794320436f6e74696e75697479202330313120e2809420436172626f6e20436f6e74696e75756d", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BlQCkAA", b"352475ee76684564087468623dcdda5f9136dffbb2b94e701445ec13622072d0", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(12, b"012", x"43794320436f6e74696e75697479202330313220e2809420546974616e69756d2054696465", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BpACwAA", b"44dc60a781a080ead1a992047b038352aed3f3c6e5a51ece983411f56cd25af1", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(13, b"013", x"43794320436f6e74696e75697479202330313320e2809420506f7263656c61696e204d656d6f7279", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BsAC8AA", b"956241ca7d496a89755a3262e74f91e24b945a7f4c39ebac6437562299e104f1", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(14, b"014", x"43794320436f6e74696e75697479202330313420e2809420476c6163696572204563686f", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BvADMAA", b"3aad7b429b8a7a242ceadb677d645e7de4073db946b2ecca35f627f23b616bc4", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(15, b"015", x"43794320436f6e74696e75697479202330313520e280942056696f6c65742047656f6465", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BzADaAA", b"bef6a3168ae50417f1d03397cb6b09548f7c190826689ac13129ae6a9edb6ae9", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(16, b"016", x"43794320436f6e74696e75697479202330313620e28094204d6572637572792043757272656e74", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B2gDlAA", b"e5769d9f7726c386ad6012735aa02369f8a50c59ffc18045eff8b90407bc1098", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(17, b"017", x"43794320436f6e74696e75697479202330313720e2809420456e616d656c20486f72697a6f6e", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B5QD0AA", b"2d2301b53d96fc92bc78f372c7dd379a4dfc14731fbecd51479566faf26b862c", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(18, b"018", x"43794320436f6e74696e75697479202330313820e280942046726f73746564204f72626974", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B9AAAAQ", b"b1f91ab498df3e99aaa8280e4cf6ed789d148b56c3bdf5aad43039f28d2cb3e9", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(19, b"019", x"43794320436f6e74696e75697479202330313920e28094204c6170697320546872656164", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BAAENAQ", b"c714294e0b2ed56be5de55b00d7b68b8a0fa018a0cc78bee9e5854f9a75bf41b", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(20, b"020", x"43794320436f6e74696e75697479202330323020e2809420436f62616c7420466f726765", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BDQEbAQ", b"0df6bfc7a547256bd299eecad1b3d98489c410a01b903f374d3e44aae794b77f", b"Rare 1", 10, arg1, arg2);
        mint_to_recipient(21, b"021", x"43794320436f6e74696e75697479202330323120e2809420476c6173732057617665", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BGwEnAQ", b"6bf02af3d87e47b74b2a9a88db882bf32177b4ded1d3f82ae4ee92e8746dbb55", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(22, b"022", x"43794320436f6e74696e75697479202330323220e2809420466f6c646564204d656d6f7279", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BJwExAQ", b"c5cf7693c61597cff655b281098cabdfb7e970c7f0601e905311f136ca6a51c0", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(23, b"023", x"43794320436f6e74696e75697479202330323320e2809420426173616c742050756c7365", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BMQE9AQ", b"cd63cc7c085195845f6658f2d2db92c77791b2b5ea5cde7e3c9642e859671b28", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(24, b"024", x"43794320436f6e74696e75697479202330323420e28094204d6f6f6e73746f6e65205175696574", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BPQFJAQ", b"6ec8f87e940f74bab9cbdd8c6ad750567dcd6bba7b046968f874da1dbebb404c", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(25, b"025", x"43794320436f6e74696e75697479202330323520e2809420436572616d69632043757272656e74", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BSQFXAQ", b"28140dd68155ec80bfc87a264e49d7d8c172ba42afae8205e06e2fb2ad07b7b8", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(26, b"026", x"43794320436f6e74696e75697479202330323620e2809420417175616d6172696e65205472616365", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BVwFkAQ", b"c47ad155c99be2f9ca7a8f221b79c7abcdb61eade399ebb15d790f02879dde98", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(27, b"027", x"43794320436f6e74696e75697479202330323720e280942053746f6e6520486f72697a6f6e", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BZAFyAQ", b"0176f4f844eae8a6a3c332284660dc6290f467d5c4b8d0d7da31ee1228dae60c", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(28, b"028", x"43794320436f6e74696e75697479202330323820e2809420576f76656e20436f6e74696e75697479", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BcgF_AQ", b"f3b7ccef28eebc34372bec01cdb5a038851862765a57e4175331472d83080fc8", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(29, b"029", x"43794320436f6e74696e75697479202330323920e280942042726f6e7a6520506174696e61", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BfwGNAQ", b"a47491fac6bb850fd3da0c891385dbc1ccb167bad889497dba4f342c34428e44", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(30, b"030", x"43794320436f6e74696e75697479202330333020e280942053696c766572204d657368", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BjQGbAQ", b"a18ef5911edf49976eacae3c28ac879721db022b3fbeb815a8c835cf4a0c986f", b"Rare 2", 10, arg1, arg2);
        mint_to_recipient(31, b"031", x"43794320436f6e74696e75697479202330333120e2809420506f7764657220426c7565", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BmwGlAQ", b"11eface14f826c949fdb916cc23f7103388b1e5bc71c1a0f6ba3684ed00093f2", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(32, b"032", x"43794320436f6e74696e75697479202330333220e2809420536d6f6b65642056696f6c6574", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BpQGwAQ", b"10de64e77da04862795f831d7962c76daf7bb8a07ce6885bd9596bbf5832d1b7", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(33, b"033", x"43794320436f6e74696e75697479202330333320e2809420426c756520436c6179", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BsAG8AQ", b"9774e2163a5daf2dbff3c38841aa6651eb5365ed30969162cad4d76e23563b4d", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(34, b"034", x"43794320436f6e74696e75697479202330333420e28094204272757368656420417263", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BvAHIAQ", b"d8f279f39b73db6a8f7703bbaf6bb014d35e6e729c431f0e1ea22b183e117b76", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(35, b"035", x"43794320436f6e74696e75697479202330333520e280942056656c76657420436f6e74696e75756d", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44ByAHUAQ", b"edaaec515cdd5dc72243d87ffd548cd5d1578006f0edf3d5932d0aae56b67ca0", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(36, b"036", x"43794320436f6e74696e75697479202330333620e28094204368616c6b204d656d6f7279", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B1AHeAQ", b"79a98c01d4ce556c7120ef73ee5dd16193d4ec3b4b5b42b7f9a0a072d83a5c60", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(37, b"037", x"43794320436f6e74696e75697479202330333720e2809420416e6f64697a6564204563686f", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B3gHoAQ", b"f2a161801cb26e3d4b85af366749b3f831a7817f0cbe241b156883070382c7b7", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(38, b"038", x"43794320436f6e74696e75697479202330333820e2809420496e6b2050617373616765", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B6AH0AQ", b"f0c8669940770ee3cfe58405a312cfdafbeb07205e89bbb21195ccd276313626", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(39, b"039", x"43794320436f6e74696e75697479202330333920e280942056696f6c657420526573696e", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B9AH-AQ", b"98c0e15fb5cfabf34da9dc252599239f3b9537190a46125bdfc8ff469c587d41", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(40, b"040", x"43794320436f6e74696e75697479202330343020e2809420536174696e204f72626974", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44B_gELAg", b"2c4fe3ea4f7c560bcd2adab4bb2ed46de729aec477450d40ecae7f698a44caa9", b"Rare 3", 10, arg1, arg2);
        mint_to_recipient(41, b"041", x"43794320436f6e74696e75697479202330343120e2809420436f62616c74205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BCwIVAg", b"94ab8a8205a9b8b85a61fc2b4ec8a9bb502a5aaa7926799abea74afa90fab12c", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(42, b"042", x"43794320436f6e74696e75697479202330343220e28094204c6176656e646572205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BFQIgAg", b"9d79678b64761d1fca6ff20a8330bb5ffc2ed47c30a5c46b150b67c24de5ab8a", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(43, b"043", x"43794320436f6e74696e75697479202330343320e2809420506561726c205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BIAIpAg", b"debd5a50d96e4170a5acd9a5a0cbab55d5166410136f1a6e16a838ce318e8cd8", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(44, b"044", x"43794320436f6e74696e75697479202330343420e2809420496e6469676f205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BKQI0Ag", b"3c17b6b8dd727d5473ea6044a10e70c866eeec3d0b8000095fd80a5b4d0c3ea2", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(45, b"045", x"43794320436f6e74696e75697479202330343520e28094205065726977696e6b6c65205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BNAI-Ag", b"4f2b3fdde07d45576cf5bc04ba9f248a58be6968f05cd139dce069fc72ae9799", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(46, b"046", x"43794320436f6e74696e75697479202330343620e280942053696c766572205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BPgJIAg", b"099aae7468c3980b2091fc0e097027e4324b8d0e20db247b1b35e03674835756", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(47, b"047", x"43794320436f6e74696e75697479202330343720e28094204c696c6163205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BSAJSAg", b"3955751b9559868c8528db9dce68fec1159b69ec09c884e1c52a12767bc8c75e", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(48, b"048", x"43794320436f6e74696e75697479202330343820e28094204379616e205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BUgJbAg", b"fd1a8cdf40d011c3d2ffa5a1e4af62c6e12090400215e9124473c0508cf65486", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(49, b"049", x"43794320436f6e74696e75697479202330343920e28094204d69646e69676874205374696c6c", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BWwJmAg", b"bd44b42e0d41a49adff6a78989bf51ee2647b32ef41ca78c879fc0c6c3e73816", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(50, b"050", x"43794320436f6e74696e75697479202330353020e2809420517569657420436f6e74696e75697479", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BZgJvAg", b"02b8846e53d6b89c0137d4effb591b3e0ee8af8703c169c65a401d49bea04f41", b"Rare 4", 10, arg1, arg2);
        mint_to_recipient(51, b"C001", x"43794320436f6c6c6563746f72204330303120e280942047656e657369732043726f776e20e2809420e5889be4b896e4b98be586a0", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BbwJ-Ag", b"41e9ec9372f06ceff584287d11dec1d5e4ee81923b462b59d7d579f324718fd3", b"Super Rare Collector", 150000, arg1, arg2);
        mint_to_recipient(52, b"C002", x"43794320436f6c6c6563746f72204330303220e280942041657465726e616c2045636c6970736520e2809420e6b0b8e68192e697a5e89a80", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BfgKOAg", b"b1bd3f4f99ec6fb324e1c5c225b05c0b0362df00b7dcacf946a85f0c8b15c379", b"Super Rare Collector", 150000, arg1, arg2);
        mint_to_recipient(53, b"C003", x"43794320436f6c6c6563746f72204330303320e28094204175726f72612052656c696320e2809420e69e81e58589e59ca3e789a9", b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/aDYtpA5SKYJ-OwGsyaGB0Y3R9wzsHii7Ms8gQCxNH44BjgKbAg", b"09837646fbad564466cefd3bfaebda734903fe304b708f12c8fc70f74927e0fb", b"Super Rare Collector", 150000, arg1, arg2);
    }

    public fun initial_price_usdt(arg0: &NFT) : u64 {
        arg0.initial_price_usdt
    }

    fun mint_to_recipient(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let v1 = Minted{
            object_id : 0x2::object::id<NFT>(&v0),
            number    : arg0,
            recipient : arg7,
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg7);
    }

    public fun number(arg0: &NFT) : u64 {
        arg0.number
    }

    public fun rarity_score(arg0: &NFT) : u64 {
        arg0.rarity_score
    }

    public fun serial(arg0: &NFT) : &0x1::string::String {
        &arg0.serial
    }

    // decompiled from Move bytecode v7
}

