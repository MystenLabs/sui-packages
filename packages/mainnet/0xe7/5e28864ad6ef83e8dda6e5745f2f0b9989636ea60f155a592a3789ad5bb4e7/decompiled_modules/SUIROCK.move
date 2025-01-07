module 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::SUIROCK {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        metadata: 0x1::string::String,
        creator: address,
    }

    struct SUIROCK has drop {
        dummy_field: bool,
    }

    fun general_mint(arg0: &mut 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getMetaDataUri(arg0);
        let v1 = 0x1::string::length(&v0);
        let v2 = 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getMinted(arg0) + 1;
        assert!(v2 <= 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getCollectionSupply(arg0), 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::err::supply_maxed_out());
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
        0x1::vector::append<u8>(&mut v7, b".png");
        let v9 = 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getCollectionName(arg0);
        let v10 = *0x1::string::bytes(&v9);
        0x1::vector::append<u8>(&mut v10, b" #");
        let v11 = to_string(v2);
        0x1::vector::append<u8>(&mut v10, *0x1::string::bytes(&v11));
        let v12 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(v10),
            description : 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getCollectionDescription(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(v7),
            metadata    : 0x1::string::utf8(v4),
            creator     : 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getCreator(arg0),
        };
        0x2::transfer::transfer<NFT>(v12, 0x2::tx_context::sender(arg1));
        0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::inscreaseMinted(arg0);
    }

    fun init(arg0: SUIROCK, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://twitter.com/SuiRock_NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<SUIROCK>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun public_mint(arg0: &mut 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getPublicPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::err::coin_amount_below_price());
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getPublicPrice(arg0) * 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getLaunchpadFee(arg0) / 100, arg2), 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getAdmin(arg0));
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

    public entry fun whitelist_mint(arg0: &mut 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getWhiteListPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::err::coin_amount_below_price());
            let v0 = vector[@0xfcb746c76f2d2bb3e5d759218a6cf89e11326cf776320ee34afa3b22886d5fe8, @0xdb8877c12e0588d1ece1c998e6c66388fea84a01f03b967179dad2b4a49b5c2f, @0x2f85e1a5a972b97afba539a2547d8ec843b4b95d727704b16caba7a9f3c68056, @0xd6e05fa3cdb53000d108c3f7f0cdca706072e34c7baa2a5791c250b7fca74a15, @0xfd9ed1351001fe0c0319dc02f13ae50ee99ac53cc7075da06728cbe88634cf0c, @0x62d443fb955eb1b9aaa0c69c04827a2a6ece853d48e00219640ad59a7d561253, @0x297ab3449839a29ebf7ba13003ed8d61c7d86c127858770dfe63d0213058960f, @0x77ecdf99c861fffc557aadeb2af9f9124721a9cf493befd253c131a92fd887fb, @0x48550a97e571c4694f063da4e008ec0186aaa3b73bfba648fe06d530820293a8, @0xd102e6fbdb645abaedb5f074167866d36f4abbf54c930b3d1435ad73de3ea9f1, @0x7805630a1b83f7ae7a3bc07543576d4a2738d0f53d06b45556d60fcb0177bcb7, @0xd451bff90c352ae5822061318ef76f4b017dc4889617624a44fc4483fe42692c, @0x6bb22ff05a12b94357f473e171c3a1f569768b235cbe33f546f448b2bfd9faf4, @0x68162bda4c13a98d6def90bab162b2d9b18971dda522e39365ef43ee4935a772, @0xa4d4b4e40519dc1a38dda39edcef1515357afff6768371c37f53565e8c37ee72, @0x407ef724efa729d7f4ce4b58004adcd5cfd25506a9226d486196399abece1758, @0x45e7111b3fdbc75ed049fdfc70abb050b498414f5e0fe93066af742d7a4ef774, @0x4c8b54f3e01aa50ff177586e4264ef991ab4faf09cd02e922c549f335e686eb8, @0x44a31db7524d445c41e3ada7868f78aba4eaba222ceaa14e2cdf9312f26eb825, @0xf732c93bc6bfba1e5443389cbeb784578bfb2e1a2ce8d41493b4b80680220c68, @0xddb7071094ebcb623121f5b9f385b5d64499981a0743e5df3929b268a433eea3, @0x446b407d4b70f2a2017180db0ecacd6b3d8e6649c2fbeb536796a5b6495e557c, @0x6a13995753927673ba4dbd54c5103e18497e412ea7202c6287113be9909988aa, @0x27086873b74793ab8297d2b8093b16f556d7a3453ff55622af4c3763540cfbf, @0x206175d1de595cf3cf5a3a738ec31181023bdfbcdc852c8ba5f8dafdbed73a7a, @0x7aaafad77bcdd8118c8733aa1ed861748b7c70940c94fad716b576c7ff97da86, @0x4844dabf6ce0b089f97fed4f9ee18fe464c15352c46b65530240c28a1174280d, @0xe7726744dc4ed1fa7c9957ac1bd1968b52ade866780a492641e7772c385d473b, @0xa508e3cc18f382dafee8782e735a804ee5696c95d5c0699d5c86257000107ea, @0xff2545d8efda85f82a77d94a6311e229cbc64f7b83ac96d4c199885aa5642dc8, @0x6c65fc165ff312bd177d6c827836d6ff77cdbe5a66c7d9f1f20206f1630b9e7d, @0xbf08360267d2fa59ffdbe2dd02acdd8d98d926331423520feabc657c61a7e6bc, @0x138e171396f9674a118ae3847aac54a9a89e9e462094d2c68c54721135bbc1bd, @0x811d1f84f0852943a3d82a5e0005dfadfd485c8d7e59ac6bad4a7bbf4f4427ad, @0x7def70ffbca90b23396b9840384817bdcf4674b963229ee505268100f95b8c50, @0x675e9c4427bce963e729ded29b97430063fb00c729da1798c13d8f8cbe316caa, @0x296168dc536f7026398230b6e03471087fe8372c89209eb86a9d568df6391f17, @0x2c12595a0cfb0a0a364d9f212e00b79092902d7a5e15a483ab0c5db8d41c2cdb, @0xa9e6ab5cf450cde44d637130d8063df0a48b509e81a5add4f57220b4c6dfdbba, @0x8c28cb8f84e82e2d58865e455ae2d17feb59832dd910c6ffd4f38db9771bae9b, @0x209fcd10dd5dcb163d0297268b1cede2fab361a116eae6d9af823458b77a7b38, @0xbe284a99cd5acb89efd02205a2f961b88bea7272d36b4a1f4220eecb10a45fae, @0xa7b9a593412318381eefd07d5f3874b23ef33c8875fc985ffc7ed410698aa980, @0x219a74f51aa7fda82b93ccde545189471977bda3643feb5c1d007464af894410, @0x9dd304c976d6059d13990f62e3d8da3757ecb7becfe3a439ae3ef7c1976614e, @0xd92748966f0521bed2a6ef79ed279186a42f2968ecd20cd4144193dd8bbed1c6, @0x570f8a9d22ceb8a469130f5d38b7aaf938bbe78dba4a7c3bba5c7b1762964ed5, @0xb6dcf45159daf0c61257fe30106b1e010c86689d0ce4ea71db64d15d6c0b2683, @0xc7e391099a546ced8770e1cf9127464b40f6fed9ad925cad451f42f5e2068f45, @0x556c763d9d84cc7eb8a64b50f56d1dd5d6e765787186d72e24d7024df445fc95, @0x774c3eef73c3ada9313c4a33b919a1565b021b4b2fa844b70ac5551be5d7896d, @0x4dc526c540640693059ddcc20ba77aa30637f39a468cfad4a7d7806d410d515e, @0xc2d84d25bc688204a7c5b9c93110f81bf3630e3667e232cb4af9050b291e310c, @0xb770f6ef4e51df94c9e0f9f03287ccd64376c22f468d7b8efe832152c302fe93, @0xc90c79fbff2743dc5688822f5d52f4e222030db1404e6b0110de4da483fad1f1, @0x4aac77c73198f6c2444ef4192c5725045edf60b2995846e7c910d8ff5364a7b9, @0xfd518f9ab35e728fdd81d16093a6ebed35347fca408474e9326463de77cf583e, @0xaf00d049f602f54397ea59f93521d3d83b078fadfb3720e9ffad37a2b0c68416, @0x6a1801385ce312b66d7a336f801e2fbb2f9ec452bd5f30949b585e2ed10321a6, @0xabc438b5dd28bcd7985a605a2862ea2a299e818e5499b4f8d912b49907d0fcdd, @0xc7a57e0e2e501c400ee3efef95c317379589818f2718a17bebc706e65bbbe67f, @0x68e6ed2a15f82315759d924d62e1b00caece0f333e12d1d150af223e8784fa4d, @0x5159c057deaa2135ed586f65c0e7839c3053f677a5ff799cb5cbb0ee1f9fb34b, @0x9ea09371df2a75d73c66b11b777ab1a0a8a54a22549545d72deb5e557059f260, @0x8ee33a4f36dd91263dce80597b663d5e91f4a2d6624c38806b556cebefd68fa8, @0x2a33a3d540fb72972ec6e36adeddfd9849b7c5fb3993c3694eeb74045987981f, @0x3f185ce0785721dd0c7c8f979732001e0695b6c4ec98e113ac9546fa4ab1ec2b, @0x403a888f7a3eb86ea2fae78238f102d96c152d2437bf759ff1a545b8366b0438, @0x262d04b044bfa46430266136d45bade35e3e9d71ce180d483e7cd1c2ac3786e5, @0x1265eee5dd04f361b343f0a944fa283ed683c1351c067fd9baeee3eaffc84e59, @0x8ae4994dfd5c75a2ee4dd94fcb80bfe858c6b4862d926e36cb7d8215fd9fd751, @0xcc263e2b94ea3ac768d76181ca68b23ee917e1ac6386947254a61d98c3c649d9, @0x2c412a1f978b0cb4183b1a47a756510b12f60d818410d1974d7ccdc75d32d51, @0xecd44d5b1fa75e1aacba8fde6c4fac54d42b6f124a0251cfaf915bef085c19a0, @0xaa14e2a8cdb30a89eb2485d1d68a073e26c0305654b642b18376e979dda0f101, @0x2f7664676649e10f0ca33bbf93fd5e6a3c10e2a4aaf3947aa8381ae69aff0c88, @0xc7938f80b99ced60e864299617956c94a95616ad4dce51a008f4d68110b775f, @0xb0b978cd3db61b9cd973532316b5de73ed8c3032dd56e30fd6fecfcc0e186afc, @0x7ebcd6adcb4a91ff0c534eea80523d6802b776b0ffe32b81ecb028e8c9294c63, @0xd4894abc6b39bd2543bbfa48fb0a49bd7f6f48d045e88f2b94707b01ae608936, @0x506c5e97b806de9f78e0c2b538d1d2f02c988396fb999e7a2228443ea2351dd5, @0xb0dca7b43cb6d80b75c5e6135e8783f1d236c7596a163ea79056fde572968f03, @0x72c5da2394f2d3461814266b2091ec26a64ec81614e324eaaf77ffde91de628, @0xa30d85ca80460c42e0ca051e721a614f516c39c2c328bef5b93723a3ba24f557, @0x5457b9b1d9d1ebdca0ae0f0eb098f848e416b5aa32a2b075ae048840584d29f5, @0x5ad0e318928fda2cb1c98c9f45b55ff7c0572c1069ff49ca4cc45184bae9a7fb, @0x6b3fb018a614d6b01d503e06a0cbc1d52c880ce8bcf29a5361b8c712e46ce78b, @0xddd1f7de1a9f0e8064bd2478d06ebc771e08714bc6c7595babf96617500140c4, @0x1d9927dd7a51e70fb8bef639883258606ce552b94ad97ffb895bd3816af546a3, @0x85b93ae3bcd7d512de45b4d5433581ecbd10783a7b10830c828d1e1546f29b99, @0xd2de8011d0220354e8e9bc17cf25cd22559c76336e17010642abbc6bf2777081, @0x69884ab694eef1c018dafd5ef68995b5331781971127f0ad00f9bb3a4bcef48d, @0x7634cc88fc5813dabac46ae1ff331c3b7f7227d91d10064ebc4827dc108577f5, @0xed7aa4f8c59ad759eeebe8293fc0c70bfb294faa61a78090dd1e50ad415cf694, @0x4b79948db615663593baa38054e2a8c685f3dae3e87faaed2807441da7c65c24, @0x52755cb0f434ffa58a63c6fa92270f941161c28e2efb7c07f35336ac22b15f29, @0x3969b014909b32ff299e7d32e6a2ce9be327bf6d03f6250a167275eca9c48d5a, @0xc8a3eef4e3a6fbddf8cf73171e2981f9c787b83fbe89ab8545873c05226b0393, @0x57e6ee6f528eaa76ca05680f129e86202bd5c2e3de9ff6f726498d33d06907e1, @0x910c19976ecef0f47b66ed3518411a1eb2369613bf15c8145216b4b56574a765, @0x1457f5d8888f180798b165a3e1c6b84f47370a2b44173f6f7f9e07936b345e7a, @0xa5e5f9d20436afb1c9975ba66a53fe6c1d4ec2d55bcd2cf5212a1d220441ccf5, @0xa68df993bb49f714bea2d8b3d3f6bc68a8531ea682593b8c37c074ffd733ad6f, @0x72c5da2394f2d3461814266b2091ec26a64ec81614e324eaaf77ffde91de628, @0x249b559751623c4934ac7dde5dbf7af5699343c4965c7add92e2127fc8154cbf, @0xc106ef4da2af3cb014cadb57e8914e3ba38a6331a79231e33d01c63a471b894d, @0x9677d251db8bef9552472a01ccb807a0ed2e24aeed364a4f3ae4f6420f98960d, @0x6ee2dca0a8b1892c33b5babb9ab4baa05181584bb6ffcf97e1e186cd5d421662, @0x9747cb087facfd537a48952359ce8ea455b987c1c11a2dd64776abb5eca4e238, @0x678d9ca446f62cea3bd9c9e32e7eb0fc6f0d6b8e47c71e13d03962bedd72a882, @0x5ece9d1d81667e005f8c7e2a6a68a2cf175f55cfc92d391d67dea363645a6479, @0xfd2908111e1c22021377750a621f96b928dc36a2f57b14e030926889df068deb, @0x7828b55ee9bfe8cad21113af9e38c0eac239696aff1c04a4de3dd559245a43b, @0x3369b03344f8f196fa67dafaef98aeafa7947b9ece8626a5ad5be555d3cd9168, @0x1873ab88b662318f3f89be8307f44394729b189672cddfb4fac1e74725333816, @0x2f2c335e6cc5239bb77548b38c3ea871b6867f3854acb70164f59247975b5226, @0x520a66670f121fc4a8d45509efa43a2013f3483a1f49c1e15711ef0fba23d5ad, @0x82c99cb0c05e827dea6fad836253cbed0f26b2cfcf1a9cf5da35d6d301f26af9, @0x39038687412e0b0f6fe3e4eddc908a7af3b563e93179f8bb15dc268c54a80d0, @0xe69b28e925cfdeea830cffdba36a3e541b28e13a3dd0fcdf8d9fbd4b3bfeedc3, @0xfe82084e6c2cfd203ef589e2c7b71a99c4866c92690bbb1ee613062c88307fc8, @0x7235cf5fc854b87aa2354691027886dbfc904200ada5eb4687ab3c857367dee7, @0x9793103ffe52a70adf0b029a10ed1dec7439a2d2aa6bde890bedaa4631c3cb23, @0xf5cf216fa895ab7f61d719cd9891c2ad567ff8769fac5f5f3963c9cd01b4ff83, @0xc7df9bd4344d39853ff96b81d65d79a51694d3d83573d2c0646383916b14508b, @0x5a8d308f17830251ea1b8914d17cb9d9d2fe54bcfe2b2f34a71c087ebb1c47f4, @0xfdde0468dbd741da17775030a41acecfc4f57f415b2d53668bbd49456a0cac05, @0x31e6827293bb09e04030993c24ce44f12c355ff0629f92e66bfe70bdf23b3d31, @0xde1da1e2fd5e7d29dee305d41eaa2d42529968ed73df8fe4d47bf6df6ee67fbe, @0x8a04e51728525b7e639d2d19a5dd99e1c83834b3a3d5fdda3bf3848f362edbea, @0x6a093f2edf5164e627e585e104591e23bc821b4caa42499bcd6360ca8f5ee724, @0xb982ff79efa25ac218a5b59523ee5a17ab373fa038f74ea8dd9326cc8c2c8779, @0xd6b341200feae6c0aaa9d55022aad0abd88111b25431fa1659f6752ed9a4894f, @0x1ad794a9a86d29840f69467254592845f6d156fd5de78d83228620f9e88e8314, @0x1fac7d0bc20e201891d9f1bc9044bca0701b09ba7d72c3afadfea4bc0256d57a, @0x8f14caa9c3fc0ac15c9f3af95af23a349bd11c485421438e84e90cd098f45491, @0x7dcf8b7aa02b84287060aa3b14b9968c5f1e6c8fca4c9c2627bcd7159ed7de13, @0xd7537869d8fbd37b8285846af6e2e8dc828e5955176d06d4fff8db9be0092e6a, @0x5ff8851e32450c63dda11befe9eb76afd12cfdadd4d5f03b75563d59c34be86, @0xa8d102b2ae4a3fa8ff71d84198005a791f8f16112652312d98aa363c35343192, @0x811d1f84f0852943a3d82a5e0005dfadfd485c8d7e59ac6bad4a7bbf4f4427ad, @0xe9181ebdfaf4aabd036d0f9e7f4d57cd6d4248a22f8da9eae7669344f983048c, @0x96167d4bfd709d29d8150d69bdcd7293b9c9ebf4ba34a05a167a4688ddd3141d, @0xfa6525189d5de12d4ad8947947be42594553bd8738585803fc32532b1ff0b758, @0x41bdf443611673695b72e26c5bfe41dfcfbc2f108f8227b214bbd247ba7b2687, @0x2965526f7928d2c872e8d09f8826a644e28ad66383020160feffaf593b0198ce, @0xb6eee332755c859378bc18ee99604fb6739a50e9c1934b7127ca4d167c9064cf, @0xf4bb42fd31c1a87acd10d0cb618a5d5990a3e0dcb3cd052b1c240814c9ae5f61, @0xc1159a46ea4bc7e20f1a17cb243a7d00395db2454f7f78be56aa680b370cf61d, @0x9df1d2e5ea4dd6909ff1c5f6594a4a97fac241b4fe6a0600c9d368c9c65e90d3];
            let v1 = 0x2::tx_context::sender(arg2);
            assert!(0x1::vector::contains<address>(&v0, &v1), 0);
            0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::addWhitelistAddress(arg0, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getWhiteListPrice(arg0) * 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getLaunchpadFee(arg0) / 100, arg2), 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xe75e28864ad6ef83e8dda6e5745f2f0b9989636ea60f155a592a3789ad5bb4e7::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

