module 0x9b64d602663ff25bdf985b6f4124372afbab0bd96b0679756c1bb425d24408ee::voting {
    struct Votes has key {
        id: 0x2::object::UID,
        total_votes: u64,
        project_list: vector<Project>,
        votes: 0x2::table::Table<address, vector<u64>>,
        voting_active: bool,
    }

    struct Project has store {
        id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        video_blob_id: 0x1::string::String,
        walrus_site_url: 0x2::url::Url,
        votes: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun assert_sender_zklogin(arg0: u256, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"https://accounts.google.com");
        assert!(0x2::zklogin_verified_issuer::check_zklogin_issuer(0x2::tx_context::sender(arg1), arg0, &v0), 1);
    }

    fun assert_user_has_not_voted(arg0: address, arg1: &Votes) {
        assert!(0x2::table::contains<address, vector<u64>>(&arg1.votes, arg0) == false, 2);
    }

    fun assert_valid_project_ids(arg0: vector<u64>, arg1: &Votes) {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<u64, u64>();
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v0) < 0x1::vector::length<Project>(&arg1.project_list), 4);
            0x2::vec_map::insert<u64, u64>(&mut v1, *0x1::vector::borrow<u64>(&arg0, v0), 0);
            v0 = v0 + 1;
        };
    }

    fun assert_voting_is_active(arg0: &Votes) {
        assert!(arg0.voting_active, 5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Project{
            id              : 0,
            name            : 0x1::string::utf8(b"suiS3"),
            description     : 0x1::string::utf8(b"S3 Simple Storage Service Protocol Written In Walrus"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v1 = Project{
            id              : 1,
            name            : 0x1::string::utf8(b"SuiIP"),
            description     : 0x1::string::utf8(b"SuiIP is the IP protection built for artist, content creators & NFT holders to list their IPs and earn royalties when IP is used by anyone on Sui ecosystem. This could be used by on-chain games to import digital assets like game characters directly into the game while protecting it's IP & earn royalties on top of this. "),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v2 = Project{
            id              : 2,
            name            : 0x1::string::utf8(b"SuiChat"),
            description     : 0x1::string::utf8(b"Sui chat is the first p2p & group chatting protocol built on Sui & walrus. It leverages walrus to store media (like images & videos) & Sui network to send messages p2p. This platform is built to bring entire Sui community on-chain(from discord ofc!). A simple KYC process could be used to link twitter accounts with on-chain addresses & directly login using NFTs & SuiNS. Different Dapps can have their on group chats with gated access."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v3 = Project{
            id              : 3,
            name            : 0x1::string::utf8(b"tuskscipt"),
            description     : 0x1::string::utf8(b""),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v4 = Project{
            id              : 4,
            name            : 0x1::string::utf8(b"de-docker-hub"),
            description     : 0x1::string::utf8(b"Decentralized Docker Hub, store the Docker image in walrus"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v5 = Project{
            id              : 5,
            name            : 0x1::string::utf8(b"Arrow"),
            description     : 0x1::string::utf8(b"A secure way for sharing files."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v6 = Project{
            id              : 6,
            name            : 0x1::string::utf8(b"Nemo Protocol"),
            description     : 0x1::string::utf8(b"The yield trading app on Sui. Fixed return & Leveraged yield. "),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v7 = Project{
            id              : 7,
            name            : 0x1::string::utf8(b"Walrus Guard"),
            description     : 0x1::string::utf8(x"5361615320666f7220456e7465727072697365204469736173746572205265636f76657279207374617274696e6720776974682061206672656d69756d206d6f64656c2c206b657920666561747572657320746f20696e636c756465202d0a312e205363686564756c696e67206f66206175746f6d61746564206261636b7570730a322e2053656375726520616e642067617465642061636365737320636f6e74726f6c20766961206d756c74697369670a332e20517569636b207265636f7665727920616e642072656465706c6f790a342e20436f6d706c69616e6365204d616e6167656d656e7420657463"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v8 = Project{
            id              : 8,
            name            : 0x1::string::utf8(b"Suiftly.io"),
            description     : 0x1::string::utf8(x"43444e206f7074696d697a6174696f6e7320666f72205375692057616c7275732e204c6f6164206d6f737420626c6f6220756e64657220313030206d696c6c697365636f6e64732e200a0a4d616e79207761797320746f20696e746567726174652c20696e636c7564696e672061204e504d207061636b61676520666f72206175746f6d617469632043444e20746f2057616c727573206661696c6f76657220616e642043444e2064656c69766572656420626c6f622076616c69646174696f6e2e0a0a5365652068747470733a2f2f73756966746c792e696f"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v9 = Project{
            id              : 9,
            name            : 0x1::string::utf8(b"Mojo"),
            description     : 0x1::string::utf8(b"I want to integrate music and crypto where artists will be paid thru sui rather than other forms of payments."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v10 = Project{
            id              : 10,
            name            : 0x1::string::utf8(b"JarJar protocol"),
            description     : 0x1::string::utf8(b"Ai gen protocol on SUI blockchain"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v11 = Project{
            id              : 11,
            name            : 0x1::string::utf8(b"LaplacePad"),
            description     : 0x1::string::utf8(b"A token distribution project based on a lottery system."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v12 = Project{
            id              : 12,
            name            : 0x1::string::utf8(b"walrus-ga"),
            description     : 0x1::string::utf8(b"Using GitHub Actions to deploy a Walrus website provides an automated workflow that allows automatic deployment with each code change, eliminating the need to worry about Walrus CLI configurations. In addition, GitHub simplifies version control and history tracking, providing clear proof of origin for each deployment, increasing reliability and transparency."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v13 = Project{
            id              : 13,
            name            : 0x1::string::utf8(b"NetSepio"),
            description     : 0x1::string::utf8(b"NetSepio is revolutionizing internet access through the power of DePIN, empowering anyone to set up a VPN node and share their internet bandwidth, thus fostering a network that is both secure and universally accessible. By combining decentralized VPN (dVPN) and decentralized WiFi (dWiFi) technologies, our mission is to make the internet safer, more private, and available to everyone. We achieve this using cutting-edge technologies like zero-knowledge proofs to secure your data, AI-driven tools to detect and respond to threats proactively, and blockchain to ensure transparency and decentralization. Whether you're a business looking to protect your employees and subsidize internet costs for your users or an individual seeking private, high-speed internet, Erebrus offers a versatile and secure solution, transforming the way we experience the digital world."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v14 = Project{
            id              : 14,
            name            : 0x1::string::utf8(b"walrus-press"),
            description     : 0x1::string::utf8(b"WalrusPress is a markdown-centered static site generator. You can write your content (documentations, blogs, etc.) in Markdown, then WalrusPress will help you to generate a static site to host them."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v15 = Project{
            id              : 15,
            name            : 0x1::string::utf8(b"Galliun"),
            description     : 0x1::string::utf8(b"Galliun is developing  Water Cooler Protocol a minting and distribution protocol for NFT collection launches on Sui along with Flow a Command Line Tool for interfacing with the Water Cooler Protocol."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v16 = Project{
            id              : 16,
            name            : 0x1::string::utf8(b"Online Selling Platforms"),
            description     : 0x1::string::utf8(b"This website is created to create an e-commerce selling website."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v17 = Project{
            id              : 17,
            name            : 0x1::string::utf8(b"Xbuild"),
            description     : 0x1::string::utf8(b"storage platform "),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v18 = Project{
            id              : 18,
            name            : 0x1::string::utf8(b"Adgraph"),
            description     : 0x1::string::utf8(b"AdGraph is an open, decentralized on-chain graph of user preferences."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v19 = Project{
            id              : 19,
            name            : 0x1::string::utf8(b"PackMyEvent"),
            description     : 0x1::string::utf8(b"PackMyEvent leverages the unique features of the Sui blockchain, such as its innovative data model that treats each digital asset as a truly unique and indivisible entity. This approach ensures that event tickets are secured as non-fungible tokens (NFTs), granting unprecedented ownership and control to users."),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v20 = Project{
            id              : 20,
            name            : 0x1::string::utf8(b"Suitizen"),
            description     : 0x1::string::utf8(x"53756974697a656e20697320616e206f6e2d636861696e206964656e746974792070726f6a6563742e204f757220766973696f6e20697320746f2063726561746520616e206964656e74697479206361726420746861742069732066756c6c7920737570706f72746564206163726f73732074686520535549206e6574776f726b2c206772616e74696e6720636974697a656e73207468652072696768747320746865792073686f756c6420686176652c20737563682061732070617274696369706174696e6720696e20766172696f7573206f6e2d636861696e2061637469766974696573206c696b6520766f74696e672e0a0a55736572732063616e2070757263686173652074686520535549204e616d65205365727669636520616e64207468656e206170706c7920666f7220616e206964656e746974792063617264206f6e207468652053756974697a656e20776562736974652e20447572696e6720746865206170706c69636174696f6e2070726f636573732c2077652077696c6c207363616e20796f75722066616369616c20666561747572657320616e642c207769746820736f6d652072616e646f6d6e6573732c2067656e657261746520616e2061766174617220726570726573656e74696e6720796f7520696e207468652053554920776f726c642e20546869732061766174617220697320696d6d757461626c652c206a757374206c696b6520686f7720796f752063616e2774206368616e676520796f757220617070656172616e636520696e20746865207265616c20776f726c642e20596f75722066616369616c2066656174757265732c20616c6f6e672077697468207468652067656e657261746564206176617461722c2077696c6c20626520656e6372797074656420616e64207265636f72646564206f6e2057616c7275732e0a0a546f2070726576656e7420746865206162757365206f66206964656e746974792069737375616e63652c206f627461696e696e6720612053756974697a656e206964656e746974792063617264207265717569726573207072696f72207075726368617365206f662074686520535549204e616d65205365727669636520616e64206973207469656420746f20796f75722066616369616c2066656174757265732e0a0a4265636f6d6520612053756974697a656e206e6f7721"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v21 = Project{
            id              : 21,
            name            : 0x1::string::utf8(b"keybase"),
            description     : 0x1::string::utf8(b"KV store on Walrus"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v22 = Project{
            id              : 22,
            name            : 0x1::string::utf8(b"Essential DAO "),
            description     : 0x1::string::utf8(b"Providing DAO solutions in the sui ecosystem "),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v23 = Project{
            id              : 23,
            name            : 0x1::string::utf8(b"Split Conferencing "),
            description     : 0x1::string::utf8(x"5361792061207465616d20676f74206120706167652074686174207468657265206170706c69636174696f6e20697320646f776e20616e64207468657265206e65656420746f2062652061206d656469756d2077686572652065766572796f6e652063616e206a6f696e20696e746f206f6e652063616c6c20616e642073706c697420696e746f20726f6f6d7320616e64207365616d6c6573736c7920737769746368206265747765656e2074686520726f6f6d732e0a0a526f6f6d7320696e207468652061626f7665207363656e6172696f2063616e206265206c696b652066726f6e7420656e6420726f6f6d2c206261636b656e6420726f6f6d2c206e6574776f726b20726f6f6d20616e6420444220726f6f6d206574630a0a536f2065766572796f6e652063616e20646f207468656972206f776e20524341"),
            video_blob_id   : 0x1::string::utf8(b"rvtweti0wlA0OeIO_Vi2sdvqV29zLDfO63Lo-sFevVM"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://breakingtheice.walrus.site"),
            votes           : 0,
        };
        let v24 = 0x1::vector::empty<Project>();
        let v25 = &mut v24;
        0x1::vector::push_back<Project>(v25, v0);
        0x1::vector::push_back<Project>(v25, v1);
        0x1::vector::push_back<Project>(v25, v2);
        0x1::vector::push_back<Project>(v25, v3);
        0x1::vector::push_back<Project>(v25, v4);
        0x1::vector::push_back<Project>(v25, v5);
        0x1::vector::push_back<Project>(v25, v6);
        0x1::vector::push_back<Project>(v25, v7);
        0x1::vector::push_back<Project>(v25, v8);
        0x1::vector::push_back<Project>(v25, v9);
        0x1::vector::push_back<Project>(v25, v10);
        0x1::vector::push_back<Project>(v25, v11);
        0x1::vector::push_back<Project>(v25, v12);
        0x1::vector::push_back<Project>(v25, v13);
        0x1::vector::push_back<Project>(v25, v14);
        0x1::vector::push_back<Project>(v25, v15);
        0x1::vector::push_back<Project>(v25, v16);
        0x1::vector::push_back<Project>(v25, v17);
        0x1::vector::push_back<Project>(v25, v18);
        0x1::vector::push_back<Project>(v25, v19);
        0x1::vector::push_back<Project>(v25, v20);
        0x1::vector::push_back<Project>(v25, v21);
        0x1::vector::push_back<Project>(v25, v22);
        0x1::vector::push_back<Project>(v25, v23);
        let v26 = Votes{
            id            : 0x2::object::new(arg0),
            total_votes   : 0,
            project_list  : v24,
            votes         : 0x2::table::new<address, vector<u64>>(arg0),
            voting_active : false,
        };
        0x2::transfer::share_object<Votes>(v26);
        let v27 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v27, 0x2::tx_context::sender(arg0));
    }

    public entry fun toggle_voting(arg0: &AdminCap, arg1: bool, arg2: &mut Votes) {
        arg2.voting_active = arg1;
    }

    public fun vote(arg0: vector<u64>, arg1: &mut Votes, arg2: u256, arg3: &0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg3);
        assert_sender_zklogin(arg2, arg3);
        assert_valid_project_ids(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            let v1 = 0x1::vector::borrow_mut<Project>(&mut arg1.project_list, *0x1::vector::borrow<u64>(&arg0, v0));
            v1.votes = v1.votes + 1;
            arg1.total_votes = arg1.total_votes + 1;
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

