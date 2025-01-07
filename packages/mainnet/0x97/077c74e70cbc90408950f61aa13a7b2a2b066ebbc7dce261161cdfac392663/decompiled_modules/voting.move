module 0x97077c74e70cbc90408950f61aa13a7b2a2b066ebbc7dce261161cdfac392663::voting {
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
        github_url: 0x2::url::Url,
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
            name            : 0x1::string::utf8(b"Sui Jump"),
            description     : 0x1::string::utf8(b"A game relying on walrus decentralized storage."),
            video_blob_id   : 0x1::string::utf8(b"U5CjLKjN_jSmpzBpQiqi7-DwLRhTDXfng5FsM_LMky4"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://1vhr1c50tul218ayp0b1dif7e1lrcx1tmu58o97lp8u04m034z.walrus.site"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/djytwy/Sui_jump"),
            votes           : 0,
        };
        let v1 = Project{
            id              : 1,
            name            : 0x1::string::utf8(b"Walrus Pass"),
            description     : 0x1::string::utf8(b"Walrus Pass is an innovative solution designed to securely manage and verify digital assets such as subscription models, proof of purchase, concert tickets, licenses, and more. Leveraging the security and transparency of blockchain technology, Walrus Pass enables users to effectively prove their rights to various assets."),
            video_blob_id   : 0x1::string::utf8(b"tafMqHCbsQZ99sofKgsOI1dHxepBvOlq1PmR-Oy9hrA"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://docs.zktx.io/walrus/walrus-pass.html"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/zktx-io/walrus-pass-monorepo"),
            votes           : 0,
        };
        let v2 = Project{
            id              : 2,
            name            : 0x1::string::utf8(b"Simple PKI prototype with Walrus"),
            description     : 0x1::string::utf8(b"Actual PKI or CA is mostly used for communications between users and companies. It involves with HTTPS, DNSSEC, and secure software installation. While users and users can still communicate by using certificates created from custom PKI/CA, it will be overkill, complicated and high costs if the communications were changed from users and companies into users and users. This prototype will be creating a simple CA that can be used specifically for small scale user to user communication. "),
            video_blob_id   : 0x1::string::utf8(b"OqZ2CJnV1RmZ_9kQv2I7GK5AL_dlZfs1fgyupcahtpc"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://dspkiproto.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/Chewhern/Walrus_HApp"),
            votes           : 0,
        };
        let v3 = Project{
            id              : 3,
            name            : 0x1::string::utf8(b"WalrusFS"),
            description     : 0x1::string::utf8(b"Imagine a decentralized file system, like a windows operating system. When I upload a file to walrus, the system can display a file and point to a blob_id. I can easily download the file stored in walrus by clicking on the file, and then do more"),
            video_blob_id   : 0x1::string::utf8(b"nHvgjOoxsd7jGQOQCKqZb48L4dYNrXh6jZuh3dAe5h0"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://walrusfs.walrus.site"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/applesline/WalrusFS.git"),
            votes           : 0,
        };
        let v4 = Project{
            id              : 4,
            name            : 0x1::string::utf8(b"JarJar FileStorage"),
            description     : 0x1::string::utf8(x"46756c6c7920646563656e7472616c697a6564207573657220667269656e646c792066696c652073746f7261676520736f6c7574696f6e20746861742063616e2073746f7265206f6e2057616c727573206f72206469726563746c79206f6e2053554920626c6f636b636861696e0a0a583a20404a41524a415278797a"),
            video_blob_id   : 0x1::string::utf8(b"muE11mnnLvstleoL4az8h0Y_psuY88CaENoNi0W1N8o"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://19mxww1lum74y3yg9o26rxtu2i5pvxq6ff66cz88v4nqi3kw3p.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/orgs/jarjar-xyz/repositories"),
            votes           : 0,
        };
        let v5 = Project{
            id              : 5,
            name            : 0x1::string::utf8(b"MvnToWalrus"),
            description     : 0x1::string::utf8(b"Mvn to walrus is a mvn plugin to upload file to walrus in mvn lifecycle."),
            video_blob_id   : 0x1::string::utf8(b"LOQJ4xS43eoBmOqp0ciA5XAP3zSH_Gfbo9_1KrMR-k8"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://maven.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/willser/mvnTowalrus"),
            votes           : 0,
        };
        let v6 = Project{
            id              : 6,
            name            : 0x1::string::utf8(b"Walrus Sites GA"),
            description     : 0x1::string::utf8(b"Using GitHub Actions to deploy a Walrus website provides an automated workflow that allows automatic deployment with each code change, eliminating the need to worry about Walrus CLI configurations. In addition, GitHub simplifies version control and history tracking, providing clear proof of origin for each deployment, increasing reliability and transparency."),
            video_blob_id   : 0x1::string::utf8(b"JSQ-xt7E7KNSKgiAL3IBT5B5_3Hk_ZMiMZFHGqynkYU"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://github.com/marketplace/actions/walrus-sites-ga"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/zktx-io/walrus-sites-ga"),
            votes           : 0,
        };
        let v7 = Project{
            id              : 7,
            name            : 0x1::string::utf8(b"Doomsday Protocol: Rebirth in Another World"),
            description     : 0x1::string::utf8(b"A strategic card battle game featuring an AI agent built with Sui's latest random modules, seamlessly integrated with Walrus for static content storage."),
            video_blob_id   : 0x1::string::utf8(b"DiGYqS9SVCvlyIVgP22LhxVBPcY5ECCtiNqCugYPjAc"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://xq917z4n9e1acc9lljw6lhopnjigg0xdu971sb07w0pdrs8rs.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/xiaodi007/AI-CardGame"),
            votes           : 0,
        };
        let v8 = Project{
            id              : 8,
            name            : 0x1::string::utf8(b"Sui-Gallery"),
            description     : 0x1::string::utf8(b"AI-decentralized art gallery where anyone can be an artist or a collector. How it works: Create your art with the help of AI and mint it as your own. Showcase your art on a stand-alone Walrus Site where interested buyers can bid a price for it."),
            video_blob_id   : 0x1::string::utf8(b"JopvwwiMJPbXnuVesP8KF-Y4GVDVbIwpsCdLoArWgR8"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://6683buvw2z7jvkg37ufutxtei0beoo45uew8vmr7uxa2vnkhxg.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/SuiGallery/sui_gallery"),
            votes           : 0,
        };
        let v9 = Project{
            id              : 9,
            name            : 0x1::string::utf8(b"SuiSurvey"),
            description     : 0x1::string::utf8(b"On-chain survey/polling/voting. Ensured privacy, data safety, security and ease of reward distribution. "),
            video_blob_id   : 0x1::string::utf8(b""),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://sui-survey.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/sui-survey/suisurvey"),
            votes           : 0,
        };
        let v10 = Project{
            id              : 10,
            name            : 0x1::string::utf8(b"Suiftly.io"),
            description     : 0x1::string::utf8(x"43444e206f7074696d697a6174696f6e7320666f72205375692057616c7275732e204c6f6164206d6f737420626c6f627320756e64657220313030206d696c6c697365636f6e64732e200a0a4d616e79207761797320746f20696e746567726174652c20696e636c7564696e672061204e504d207061636b61676520666f72206175746f6d617469632043444e20746f2057616c727573206661696c6f76657220616e6420626c6f622061757468656e7469636174696f6e2e0a0a44656d6f3a2068747470733a2f2f73756966746c792e77616c7275732e736974650a0a566964656f3a2068747470733a2f2f63646e2e73756966746c792e696f2f626c6f622f61344433656d6a67596c655553754375614975353162365041454269435f64646439647a73706f766869550a0a4d6f726520696e666f3a2068747470733a2f2f73756966746c792e696f"),
            video_blob_id   : 0x1::string::utf8(b"a4D3emjgYleUSuCuaIu51b6PAEBiC_ddd9dzspovhiU"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://suiftly.walrus.site"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/chainmovers/suiftly"),
            votes           : 0,
        };
        let v11 = Project{
            id              : 11,
            name            : 0x1::string::utf8(b"Diffend - Divergence Terminator"),
            description     : 0x1::string::utf8(b"Diffend is a decentralized disagreement finisher used to resolve previous disagreements between people and record them permanently on the blockchain. Users add bets, and the winner wins the bet. Those who participate in the voting also receive a 10% reward."),
            video_blob_id   : 0x1::string::utf8(b"8OtVO0d5cavTrMxAjZP-VKsjaSu3OUpI6r0HeyKxuP8"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://diffend.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/Wujerry/diffend-walrus-sites"),
            votes           : 0,
        };
        let v12 = Project{
            id              : 12,
            name            : 0x1::string::utf8(b"sui-ai-agents"),
            description     : 0x1::string::utf8(x"5375692d41492d4167656e747320696e74726f647563657320612063757474696e672d6564676520646563656e7472616c697a6564204149206167656e74206e6574776f726b2074686174206d6572676573204149207769746820776562332c2061696d696e6720746f206372656174652061207065726d697373696f6e6c657373206e6574776f726b20666f72204149206167656e74732e205574696c697a696e6720776562332c2069742070696f6e6565727320616e204172746966696369616c20496e74656c6c6967656e63652066696e616e63652073797374656d202841694669292c20656e68616e63696e67207472616e73706172656e63792c2073656375726974792c20616e6420656666696369656e637920696e206465706c6f79696e672c206f7065726174696e672c20616e64207472616e73616374696e672041492073657276696365732076696120626c6f636b636861696e2e205375692d41492d4167656e747320656e766973696f6e73206120667574757265206f6620646563656e7472616c697a656420696e74656c6c6967656e7420736572766963657320616e642066696e616e6369616c2065636f73797374656d732c206f66666572696e6720616e2061636365737369626c652c2072656c6961626c6520706c6174666f726d20666f7220646576656c6f706572732c20627573696e65737365732c20616e6420757365727320746f2065786368616e676520616e64206d616e6167652041492073657276696365732e0a0a5468697320706c6174666f726d2073747265616d6c696e657320746865206f7065726174696f6e616c206672616d65776f726b20666f72204149206167656e74732c2073696d706c696679696e67207468652070726f63657373206f66206d616e6167696e67204150497320616e6420737562736372697074696f6e73206279207574696c697a696e67204167656e742073657276696365732e20546865736520736572766963657320656e61626c65206167656e747320746f206175746f6e6f6d6f75736c79206d616b65206465636973696f6e7320616e642074616b6520616374696f6e7320776974686f7574206d616e75616c2041504920696e746567726174696f6e732c20666163696c6974617465642062792074686520696e746567726174696f6e206f662063727970746f63757272656e6379207472616e73616374696f6e732077697468696e206120646563656e7472616c697a65642041492066696e616e6369616c2073797374656d2e0a0a5375692d41492d4167656e7473207573652057616c72757320746f2073746f72652063616c6c206167656e7420726573756c74732c20736f2065766572797468696e672069732066756c6c7920646563656e7472616c697a6564"),
            video_blob_id   : 0x1::string::utf8(b"3yEQlCV_2fQ4ZETNNUnLdmv2BPQFi5EpZAVtN-izRTo"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://2yjupvm8x2yun1ooob9yu7ixkp4a1irk10xnn5sd94ra3dbhva.walrus.site/#/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/fantasyni/sui-ai-agents"),
            votes           : 0,
        };
        let v13 = Project{
            id              : 13,
            name            : 0x1::string::utf8(b"Tuskscipt"),
            description     : 0x1::string::utf8(x"5475736b536372697074206973206120547970655363726970742d6261736564206e706d207061636b6167652064657369676e656420746f2073696d706c69667920646576656c6f706d656e74206f6e207468652057616c727573206e6574776f726b2e2042792070726f766964696e6720616e20696e747569746976652041504920666f72207365616d6c65737320646174612073746f7261676520616e642072657472696576616c2c205475736b53637269707420656e61626c657320646576656c6f7065727320746f20656173696c7920696e7465677261746520646563656e7472616c697a65642073746f7261676520736f6c7574696f6e7320696e746f20626f7468205765623220616e642057656233206170706c69636174696f6e732e2057697468206275696c742d696e20737570706f727420666f72205479706553637269707420747970657320616e6420666c657869626c6520646174612068616e646c696e672c205475736b53637269707420627269646765732074686520676170206265747765656e20747261646974696f6e616c20616e6420646563656e7472616c697a6564206461746120617661696c6162696c6974792c206d616b696e6720697420656173696572207468616e206576657220746f206275696c6420696e6e6f76617469766520626c6f636b636861696e206170706c69636174696f6e732077697468206d696e696d616c206566666f72742e0a0a496e206164646974696f6e20746f205475736b5363726970742c20746869732070726f6a65637420696e636c7564657320612073746172746572206b69742063616c6c6564206372656174652d7475736b2d6170702c2077686963682068656c707320646576656c6f7065727320696e746567726174652053756920616e642057616c72757320696e746f207468656972205265616374206170706c69636174696f6e732e2057686174206d616b657320746869732074656d706c61746520756e6971756520697320697473206162696c69747920746f20636f6e7665727420612052656163742061707020696e746f20612057616c727573206441707020746861742063616e206265206465706c6f796564206469726563746c79206f6e207468652057616c727573206e6574776f726b2e20466f72206d6f72652064657461696c732c20636865636b206f75742074686520524541444d452e6d642061742068747470733a2f2f6769746875622e636f6d2f536f7262696e2f7475736b2d646170703f7461623d726561646d652d6f762d66696c65236465706c6f79696e672d746f2d77616c7275732020616e6420746865206c697665207475736b2d64617070206f6e2057616c7275732061742068747470733a2f2f346239306864356131726d677a7435626b677130626373693278397271337536676d6938656b36766d32343073706a6f67642e77616c7275732e736974652f2e0a0a537461727420696e746567726174696e672057616c72757320696e746f20796f757220644170702077697468206e706d2069207475736b7363726970742c206f72206372656174652061206e657720756e697175652069646561206f6e2053756920616e642057616c7275732077697468206e7078206372656174652d7475736b2d6170702e0a0a2d2044656d6f20566964656f20426c6f6249442028646f776e6c6f6164206173202e6d7034293a205833557173717a35324f61614e7a716a59335f6d6c516a66484b32794e6949496f6f527242766633490a2d207475736b736372697074204e504d3a2068747470733a2f2f7777772e6e706d6a732e636f6d2f7061636b6167652f7475736b7363726970740a2d207475736b73637269707420536f757263653a2068747470733a2f2f6769746875622e636f6d2f536f7262696e2f7475736b7363726970740a2d206372656174652d7475736b2d617070204e504d3a2068747470733a2f2f7777772e6e706d6a732e636f6d2f7061636b6167652f6372656174652d7475736b2d6170700a2d206372656174652d7475736b2d617070206f6e2057616c7275733a2068747470733a2f2f346239306864356131726d677a7435626b677130626373693278397271337536676d6938656b36766d32343073706a6f67642e77616c7275732e736974652f0a0a2d206372656174652d7475736b2d61707020536f757263653a2068747470733a2f2f6769746875622e636f6d2f536f7262696e2f6372656174652d7475736b2d617070"),
            video_blob_id   : 0x1::string::utf8(b"2-X3Uqsqz52OaaNzqjY3_mlQjfHK2yNiIIooRrBvf3I"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://4b90hd5a1rmgzt5bkgq0bcsi2x9rq3u6gmi8ek6vm240spjogd.walrus.site"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/SovaSniper/tuskscript"),
            votes           : 0,
        };
        let v14 = Project{
            id              : 14,
            name            : 0x1::string::utf8(b"Random Direction Shoot Game"),
            description     : 0x1::string::utf8(x"47414d452052554c45530a0a6e6f726d616c206d6f64653a0a0a572f412f532f44206f72204172726f77206b65797320746f206d6f76652e0a0a466972652062756c6c6574732072616e646f6d6c792e0a0a506f696e7473206172652073636f726564206261736564206f6e2074686520696e697469616c20726164697573206f6620656e656d6965732064657374726f7965642e0a0a4166746572203130302062756c6c6574732c207468652073636f72652077696c6c20626520736574746c65642e0a0a496620796f75722073636f72652063616e206265206f6e20746865206c6973742028746f702074656e292c20796f752063616e2063686f6f736520746f207061792061206365727461696e20616d6f756e7420746f2075706461746520746865206c69737420616e6420676574206120756e69717565204e465420636f6c6c656374696f6e206174207468652073616d652074696d652e0a0a7261696e626f77206d6f64653a0a0a596f75722062756c6c6574732077696c6c206265206f662072616e646f6d20636f6c6f72732c20616e642062756c6c657473206f6620646966666572656e7420636f6c6f7273206861766520646966666572656e7420656666656374732e0a0a5768656e20796f752067697665206120666174616c20626c6f772c20796f75722073636f7265206d617920696e637265617365207369676e69666963616e746c792e0a0a497420697320776f727468206e6f74696e67207468617420796f75206e65656420746f207061792061206365727461696e20616d6f756e7420696e20616476616e636520746f20656e61626c65207261696e626f77206d6f64652e"),
            video_blob_id   : 0x1::string::utf8(b"lzHY6gnFLr3ZhLraFELutYNEso6GczYPyGWzdJTUQ3w"),
            walrus_site_url : 0x2::url::new_unsafe_from_bytes(b"https://zcy1024-walrusdevnethackathon.walrus.site/"),
            github_url      : 0x2::url::new_unsafe_from_bytes(b"https://github.com/zcy1024/WalrusDevnetHackathon"),
            votes           : 0,
        };
        let v15 = 0x1::vector::empty<Project>();
        let v16 = &mut v15;
        0x1::vector::push_back<Project>(v16, v0);
        0x1::vector::push_back<Project>(v16, v1);
        0x1::vector::push_back<Project>(v16, v2);
        0x1::vector::push_back<Project>(v16, v3);
        0x1::vector::push_back<Project>(v16, v4);
        0x1::vector::push_back<Project>(v16, v5);
        0x1::vector::push_back<Project>(v16, v6);
        0x1::vector::push_back<Project>(v16, v7);
        0x1::vector::push_back<Project>(v16, v8);
        0x1::vector::push_back<Project>(v16, v9);
        0x1::vector::push_back<Project>(v16, v10);
        0x1::vector::push_back<Project>(v16, v11);
        0x1::vector::push_back<Project>(v16, v12);
        0x1::vector::push_back<Project>(v16, v13);
        0x1::vector::push_back<Project>(v16, v14);
        let v17 = Votes{
            id            : 0x2::object::new(arg0),
            total_votes   : 0,
            project_list  : v15,
            votes         : 0x2::table::new<address, vector<u64>>(arg0),
            voting_active : false,
        };
        0x2::transfer::share_object<Votes>(v17);
        let v18 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v18, 0x2::tx_context::sender(arg0));
    }

    public entry fun toggle_voting(arg0: &AdminCap, arg1: bool, arg2: &mut Votes) {
        arg2.voting_active = arg1;
    }

    public fun vote(arg0: vector<u64>, arg1: &mut Votes, arg2: u256, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_user_has_not_voted(v0, arg1);
        assert_sender_zklogin(arg2, arg3);
        assert_valid_project_ids(arg0, arg1);
        assert_voting_is_active(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = 0x1::vector::borrow_mut<Project>(&mut arg1.project_list, *0x1::vector::borrow<u64>(&arg0, v1));
            v2.votes = v2.votes + 1;
            arg1.total_votes = arg1.total_votes + 1;
            v1 = v1 + 1;
        };
        0x2::table::add<address, vector<u64>>(&mut arg1.votes, v0, arg0);
    }

    // decompiled from Move bytecode v6
}

