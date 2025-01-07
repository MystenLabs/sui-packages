module 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::SUIDOGGY {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        metadata: 0x1::string::String,
        creator: address,
    }

    struct SUIDOGGY has drop {
        dummy_field: bool,
    }

    fun general_mint(arg0: &mut 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getMetaDataUri(arg0);
        let v1 = 0x1::string::length(&v0);
        let v2 = 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getMinted(arg0) + 1;
        assert!(v2 <= 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCollectionSupply(arg0), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::err::supply_maxed_out());
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
        let v9 = 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCollectionName(arg0);
        let v10 = *0x1::string::bytes(&v9);
        0x1::vector::append<u8>(&mut v10, b" #");
        let v11 = to_string(v2);
        0x1::vector::append<u8>(&mut v10, *0x1::string::bytes(&v11));
        let v12 = NFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(v10),
            description : 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCollectionDescription(arg0),
            url         : 0x2::url::new_unsafe_from_bytes(v7),
            metadata    : 0x1::string::utf8(v4),
            creator     : 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCreator(arg0),
        };
        0x2::transfer::transfer<NFT>(v12, 0x2::tx_context::sender(arg1));
        0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::inscreaseMinted(arg0);
    }

    fun init(arg0: SUIDOGGY, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suidoggy.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<SUIDOGGY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun og_mint(arg0: &mut 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getOgPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::err::coin_amount_below_price());
            let v0 = vector[@0x530bd540021b3593f1a3e3201783ef73ce0f41e4035958acd45092fec6ce3345, @0x213d099c958c2e4a07df5dde42a0e06230ed6847a9d90904034050517f5435d, @0xa5623c0139a3fa923418991af3f0e1fe81b2e6f7c36bcb1c5634a43d6abaf066, @0x2136708b4eba01cee9b024443cd1d075331a5490c944415c7361d5ac4abb7390, @0xa5341860f9cac85358402aabdf1cf8a69e0006a5c618b8ea6382377de74e647a, @0xc190a842e7bb4e55d039018da31619b2b61912a297038872b76ae59901d82ed, @0xf302135e19183a777c8468e5dfe3d0f0c697a93d8adad88bd03a9307f523ce87, @0x4df859766b9e9e586e6c16877cde61fb065b26f20d0f0bc8afd317925182ba22, @0x966bae7e89dd7c33e0bad1fbf95c2a22ff0077b49bf803a6d7afefd85de1d0ee, @0x1c2665c18c083e6d64cbe8e5823978ac4619a7093a56d30edf706634dd69c629, @0xcc64e0c4105902f0e765eff05b45e90c0d9099a457d28c66a852ab9cfe82c94, @0x32a6f52299df7c609a87f4e2155a05d280f9be58730fda79ccf100fabc0c6d7a, @0xd51a9293395fa83249655048a017c92db9b2572cf44a78d262ef79c64e8a548a, @0x3dcfebd3f10bceff4e06ba65a73618b6019c3c0b3e5e115f0a79ef0f028f04dd, @0xfc20ef2530ac5352b78f89434b188553cd08dad032344eadb94e48842661531d, @0x3a5de0d1605a1b112671e4974ea978d08b6d2e26e1b802a8afb38c0d6c0dbf69, @0x1445d5672242f07477ebdd18ed730e8cfd0a4befd77ee33c568725875b6762fb, @0xde70d84d165d6554c2eca8087289aec17a1062e5e5660dbd78ae92eef7b8e1b9];
            let v1 = 0x2::tx_context::sender(arg2);
            assert!(0x1::vector::contains<address>(&v0, &v1), 0);
            0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::addOGAddress(arg0, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getWhiteListPrice(arg0) * 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getLaunchpadFee(arg0) / 100, arg2), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    public entry fun public_mint(arg0: &mut 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getPublicPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::err::coin_amount_below_price());
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getPublicPrice(arg0) * 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getLaunchpadFee(arg0) / 100, arg2), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0));
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

    public entry fun whitelist_mint(arg0: &mut 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0) != 0x2::tx_context::sender(arg2)) {
            assert!(0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getWhiteListPrice(arg0) <= 0x2::coin::value<0x2::sui::SUI>(&arg1), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::err::coin_amount_below_price());
            let v0 = vector[@0xb355a6d683d37899d627c338377d10d6885f1ec4fb34c746f06477c0243a74d7, @0x41537a9ba1309ae9446b343108bac4110eabc9b7cf3522bf327aa70629c4202c, @0xc211101c625c50affde861dad388e4756a049b447981a333977c7e545bfe072f, @0xcf75d856a1e3dd274e7ea76a93f25e3c64996e7c0c9cc110b605010fc6d331ce, @0x8f541a609798cd81c001fb92616422ba58f98b4ce6f624e61e5edf26b9486386, @0x9258a7bb326108da7b679c502ab884c61076b455d90c40a1ae75325774e9e121, @0xf7ac0ed480e1feb540adc60799e09bc1c8685aef94d95c79b62b1fefbddbbb67, @0xdcca293dc56a3df57f74c37623e895e446f7432fd83601b31f7cf2190a37d008, @0xf10a5c5f1ab546ede84141064558f2634e1baf28ed4c9f682c3b2853c208be7e, @0xa10c2f23f61eb3c6ee5c3515a67ce481ea3a1543ed2ff8de98e4fafe1d32e73f, @0x5057652107a999647c5f18ac1c9a64e905cff95fa573e367864a37c961dd1e6f, @0x5e716797f995c960b9c2af5c83bcae4c90ca70291124d469b83d507c646c23e9, @0x8dbcf42586eccfe243505c6afa6e680a468d92733abe2757f0880e1c9b41e3da, @0x27266a6a44988bbe0993fa7694e817594ecfc4cdf1795f7e440b37019ff24d18, @0xf848090b8698634bece4302cba9481f1582c2b364ae44efd08d0b23acbedd7d8, @0x20deaaa413aa835d2310fbfa872a0a4c82a470efd65b17b99b5fe37878b9dc58, @0xd504ef9b7f18a43336921d6ac990dda3d075154e6eaee3c29d5d3d101e3e9c19, @0x54e1958f9c35dcf9eb77eddd86071a4dacf57f36c82f64d05197b5d80430088, @0xf43c36456ea28a126e31e0c61216b7d4c261c85476bb12cba00c46d8874140f5, @0x71430ad4a032b3f985e0b3f0bfaee3dd9f2516c4b497baa678aa18f856fa2432, @0x350201c9fbf01fb57a0e48743e4a40c7aaa562b0c77113b3b8fcb40ae22e1963, @0xd52788f916bab9c3eba08a040c8a24477ace61a0cd382b676fb0cc4a8aeeecc, @0xe3fbe88da78a5fe6b71b9a184daa40f2754214984513ae08b2c5d0ad950c4461, @0x2a25bb9b6ad77f59d4657c66db074b87ead4ced9f457df14f9bd54a59791d12c, @0xb649f573c67191b795dd0a8ee33c7c58f49254850d18f01ea2f67900d4df70, @0x6756a8499b0fc80af7c6b1b56f37315b84a1f04331697b6c1b86ffc7d972cfcd, @0x721eb8971cef94bd46bdf45e9eee610b67e2b2bfcbbb50f1110defd199074d05, @0xba76c85826e44a1a78f3b671946d360aed344c8dc11c575d30a0f106aae8185b, @0x8dc71477ab1c38dfb755a9d0595ac4c681966227c1bc04a4435e3e83ef68a982, @0xf961357a8aa9f402933937504cbbae3c805f1ddcd4ecc3fb6ebdbf5441b72544, @0x96048f5142532d3221a8e3ed6fbea6b03cf2a79cca358449484602be8faaefae, @0xcf5965cb719dc11a7a02386a24b0b600bc94bcf41ba1eee613986a35caf02218, @0xa4408ed3a1be1896b2e0520cbfb334a5ff6f7c4ad3d9fc7dd5aa2327143dbde2, @0x90e78a9379871c56c09bb383cdbb7049482620fc6831ce4670ee006cf18e7ff9, @0x686270a7a718347a068b9a51a19511b335a0abdc109427ded89179ece5e1df9f, @0x15ed1db6f74b7fc453b2c2b5c080b2e56f3ea0ab2f391d122840c7567e4405a4, @0x7e7ad44a6ef4c34077c37553e839b5697e875bc4d235685605b954278f5f5898, @0xa502935c6682d746adac8f980a811546a6dff08eba9e33b5ab214db50fd7d1b2, @0xbed83a9857f26ff8e1209c36d49648acaaddce5f6d4a452358a73e78f3f7c4ad, @0x44eda4367820c50f873332e736f00e52dc3f485f94d68cc40e6f8875a811780c, @0xf72251fccf2387ac76d1760ac9ec025aad24e347cfd78a463ddab929a3aec25, @0x1b8213fd1b8ee1ec2228bd8fe255f8381d3f41e5739fb950eb2a7d0bc3e22f18, @0x74727128fbbf640b1d19122973b64c0cb73b2a786d6c703510a3ece20f7fc402, @0xc776f7c14379a72ee65853014658dcd43852eac9b0627a2aa226b3635feeda85, @0x16237d390a54b86a427cf9f450447a67060290a966b7690f394a2089fc6ef5e0, @0x530bd540021b3593f1a3e3201783ef73ce0f41e4035958acd45092fec6ce3345, @0xf5875b52a7a1da4f36c39143d4b74d3be2b4e70c95868dcc1d821a014bfa6eb, @0x213d099c958c2e4a07df5dde42a0e06230ed6847a9d90904034050517f5435d, @0xdca079128dd868e3f79a52ee958f9008e1b2de625d83489ecb9c1a279cf448ea, @0xfc4be4d8295ae0277ce78a4bf9f7c3297ff3dbcfe73a73c153b3b56014128d25, @0xcaa2156444572885025f8bafe7ed9d8ee1fa2ce0b03080ce6f0ac0c0837ee263, @0x2258a983bdd7eb277e24df1792c2f046cb6b6ac0d07b90cd4122988f0b595dd2, @0x8ff590245ad50a2477ba5d343c0638f12306e6daa878bc9c30206fc3cc35859b, @0xa1df606147fac59f189a239a668ccb24553b5650721fa58f4b2861db48c0e198, @0x4d8598c462f969ee36bae9a5142b352e3f33a219138a9982875e2c8bc2759756, @0xfce5ccc60c4847f4b1bbcad0b8418f41252a7e9101a484034d0b64c4c7a6e68d, @0x143d625313646d5ff5b1996315a845cd73e95a6fa705d68f8a13a24b22caacce, @0xb31beb85e6eeac7d12e0cd62c85e40e6a4fee10d82e971fcfc96502f90710e12, @0xa5623c0139a3fa923418991af3f0e1fe81b2e6f7c36bcb1c5634a43d6abaf066, @0xd2d4b787edd9e4c8a120b1f0045339033ad825a285e0269f3f922ec6c9486178, @0x93d5da1a766809e2eb9110db5f0ae168c37a7ec294ae54625d678f77a6caab76, @0x2136708b4eba01cee9b024443cd1d075331a5490c944415c7361d5ac4abb7390, @0x69e33c3a4380c37a9ef7c30023d1cae83ca3745d670f8a881a971d492c87ace6, @0x5ba69ea6d0f665e2c3996b0acc6e8c5f74496dd562756787954f6dd6df28e2f9, @0x6115681fe1f028d89070091e83a643aaf5634a1030ac93641013350bdf989512, @0x8f11262ed55df7794bfc97db27a1d2f85278c847d0780d021a4847081db32cf4, @0x46ae891a458d518f8d3a7f322a0999bffce0bc64c11169d93edec9677b2a02de, @0x61c81c9f7c9a5d126a4a7f75d2812446c7edb5e6f60a9c9d806345027bf39c36, @0xbfbbae151e6db3d03d02fb92c0e6a5e09389158f69fe20c351cde23373c33ce0, @0x53fa573f3ed325fec108b0e83e7a43578b1a738b082861b93eb27c5e6adee7a3, @0x4e107abbe618cfe5b7e3fabffc16c7963dbcdbea277d20f354024e75ca10be1f, @0xb1ba2640d2e7318db91766622b882ee754f66441964140e27787a2fe374aeb1d, @0x7b2fe83368c4ea8cfc2483719016c2856d11b4f78bd5fb97d059be973bdd3834, @0xbf01c8a4c26410f75b99a74b415b28b824f73de17edeb591068be84f5413f67e, @0xa5341860f9cac85358402aabdf1cf8a69e0006a5c618b8ea6382377de74e647a, @0x7cc974ce33608058757e82380307a1711f58334647f0a6455acc9da2a4153eca, @0x617cf4cdd4afd382310d0a396e26d1f011c248ff7b0a3bd580ba25f1d60c8829, @0xa4c3385aa8a1221cd11aeac85202e8bb19c72b72e17dab2bf7e52e9f45c8ecd, @0xfed2b6266e7c36004bd50458d7d4e4f6ed7a58dac75be73f40c3bee9de66c5a3, @0xb0773c321cf61dd39dc0dfdd34a186e461ff6ae0e90e7fa8b39db459e941e94c, @0xa2a0f9f062fd29e7e3efe2f80c4fc99419b959b31524c8cd756deb71acf93047, @0x9ba8df7156529361f450ea0169a816a5d9d31f391a5850fa4fc12216d5dc0029, @0x342c5653ef92f42c92e627bf8b143d2ab1c3512461983323f8a379190c482e32, @0xf777ee614105805d50be68d75fbafc66ca081e592a2ffb5cf7ba7309117887e1, @0x73b3ff5e6ed45f56513c8f57ec334bccd0f76a0d554dd6a160a1fbb0615b7f45, @0xc190a842e7bb4e55d039018da31619b2b61912a297038872b76ae59901d82ed, @0xd24d10444f396155090872f2cc595b249e5a433f0a57760c201a5a7b2bd08b8c, @0x8959d138e1767eb32d961fb61c47e2c05f2118019415e255f9cf02bea679bb86, @0x6ea590e580a74c8c16f5d06daa1406107c1ebdd976e47c2d65f966f6c45a55d1, @0x974ed176d1926229a5ab2abfe860b9f60109e31532968cd565cd72c3cf43a128, @0x9ea2775d2fcf9bd6b2030b66676167a2f91dc4fcda990a40201ffee709aaad78, @0x26183ee72eadd295e05043574f2631f5c4f9180c2f62c4d633f4c8d145964c9a, @0xa582ffaa20e6076374a2b1aabe13c70546d548525ae7997bec750b6663b569a8, @0x667aaa272085561a714e09ce3598b8892cb7af8a77cb2966f7c94f1e3a06e2c0, @0x20eb7c6fc3779320b0aa55aee0902ca35713094f5ab92eb6471cf5ed4285b7f7, @0x4c3f8faa4ab321604d971ee99c6df594c1c27e5ae50b0461f5116d70971acd18, @0x4279f83bd01696a94414b0774dd7b4e2f837f9ff8ef7d7f01525249af6cb5b63, @0x95c21321bd6970c6ceb66016e74252a3c0278685445f720ebac833567ff20502, @0x8fbb64babbeeb2c4d9a4c1e5c1f076017ff8a7375062bf064f24b0f317d911be, @0x54998cd0a97ddc6176def1b0c8fecc29d65c6018c870012aec6adc9a14531869, @0x8d5268d9e18e94a073501360f8bd93893149a07ef7c859c8da6d3347b037c1a5, @0x87a24a22f0e8453922e5d74c5a2780d9ead8225c66ae283584c96994e745cc3d, @0xbc9942e91aef2637f30f6cae3a18cd5d33ba71b14bb6b2d5ba6f8fc2d5664ec0, @0xcb0279a0b3890510ac166f239a38f99ca997316b880bc06abdb6360ac953bf5c, @0x66c18415e89c9c08b1e279f48ae38a1b100acbe8c38a8c03726c22fe2d9889f9, @0x6f011d7b7d1d754ea119144175ec5e5783a7426c9bdcbe734aafa5d4883b2eb5, @0xf901569882f633d4695381da21d5ac47c359b79736d44938ce6181f1489482d4, @0x160fd1d65154ab7e27d57db206f98598a7fa630c742e57e5f112684f74c95c1d, @0x609a62b3a73acc90d514510bd54e84260dfac5f42820068ed8c4f062eb0f915e, @0xf302135e19183a777c8468e5dfe3d0f0c697a93d8adad88bd03a9307f523ce87, @0x40641977b0f054a33a715213f4c155503cff243c966e33ceaf30103d64f4e8f9, @0xa7d41c5381d9a31bc4033b532279ef69c11106beaf8891bf954f315e75b362c, @0x7969d28238bec5a2b75574bbeeb2d09413ebe82eb467ec4087246a60223e9e94, @0xb9731ff63b0ffefc72d7f804a6de4f91676820b1b7e6734879178383f01174a8, @0x84eec5448c9787c1bb599955b413ea93be8932ddd2c047da795733635eec7682, @0x4e967975b9d1e5cc587048914197f91ba0af74835227f856fd41566e668c5b9b, @0xd34cff7c51919c83c700427a70b6870d5bd87964552fc2ed3d0db5a0be0770d, @0x4df859766b9e9e586e6c16877cde61fb065b26f20d0f0bc8afd317925182ba22, @0x1a7fdcabeda557b351013f6b330cc40afac5a3a370248aa606a1529cc160b0af, @0x19b43bd0709af83ba1ddc79f790f669e52ab219d2d719fcf0423e41e2a98255e, @0x30c3ed4be75d3959c480799db17efce86e4807469b0da3d53471ba9e13f3951, @0xdb850bef26de83d72a4d992ad8b6ba5013d4e599e748648f94d5c55c3629de18, @0xf990059a1c71d31f192e784e84732137adb6ef6e627047c10d83fefcbae6d812, @0x7a6f172bd3fafecc03c840a9184f21eb92f01d86f6a495c588c07ba1a449849d, @0x194a7432739ad269ed76868b821dec40872d818385df5f77450575d6637c977c, @0x9b7388e4b24bb1ebcf3b56af33ba42b6cdf7daa01911d49999a7db3be0355309, @0xbdab328f9be57a97542a89566ba1e4d6fb2435cf7777a0734246f60cccd923ad, @0xcc64e0c4105902f0e765eff05b45e90c0d9099a457d28c66a852ab9cfe82c94, @0xd613185d91c530a3c24471bd8b00bd33d42e9de3a9946f13963026466edca01d, @0x7fc8056b406f417ef8b617f8de15e8a38f0ab2250f98b6d5521a88cc0eefe8ac, @0xd51a9293395fa83249655048a017c92db9b2572cf44a78d262ef79c64e8a548a, @0x4d453a82e9885d6273bad1c20bb3d6ae9f5ccae319da49e869c68cf0a95310dc, @0x2dd3dace5af7bde15dd59fab3e1fc181a88dcbb60f497385f4c511f14b516faf, @0x395dc1aa77c4143dc42e8db864f8fa4fffdd089bdf4a3165bd6cc86b5aed54f8, @0xc0a65b5b262bf93d103956cbb192ddf88bb593f4ec44fa6356abe7dab260699b, @0x24180fcec9ba5f96d8f225aeaa4e683ee1914a9cf6ae162a53da1caf0b7e1366, @0x23ca1d759322f2fefdad3d5241f7a390bdaa5857adea51ef9f35b8eab3ebebc4, @0x3394af8afc161b72345728c55e08095e6da1c3c3091a78fa6d2abf668504c308, @0x23427c4ef2e4ae743c735e7631f745dfcf65e2b7b1506dd7bb3348da616ff167, @0xf452692d9f3c82783d831b923526816b510134fa70e731c3be1b868f9bcd265f, @0x9a568c174978cde79f47417edaf57df9abe78aa1276d82c358c936a2c764da1f, @0xe1cb1f3585c3091772341feeabab751769d79f09758965c22d5020a1e17f8876, @0xdd1b7c35f2681f9c9b0d86a2fbe8f2eefa1b12da475479c786c4e190cbc048dc, @0x7b9702f1a4ffbebf629896dd13a8465226b3b1f5be8cee54ff8df530146a9f30, @0x86b09d5132631ae055eeec6e87543752e354feb184b50697f48851686b7cc8da, @0xac450ab87c2cd97510d3f0dd236f82a2acc47af3d9779a63ab594549ca3fb193, @0x61f9bc5d673b974396973de79113bbe6a6e518706bdf9b61c364eb5ba739251b, @0x695740a40f12fb51aceb8caaa956f5eeb5dc5479d6a20d502f3b6dfcedf5b247, @0x569f40db68c169a2d5695ec0e0824399dc121814e1801c31a6b744352a710a3f, @0x8a34255f23323c3f915bb355be2cf6c21168c888355a32dd039375488a6fe922, @0xdc20fafb3c5a4eff25307149763accc9bf903951d4265f68c6717d1f76aefa4c, @0xcd2f1b54da694776578ef2389e600f2cbfd526a1afc028ea34d40183fae4b5d9, @0x3326138f8fe5be857bf7f8038b5f86686f9195fe24721b9e810db2b3497b5233, @0x924a5185a044317baf9a1b5ea53edae7e3cc5e454718917ec41047b3188861e5, @0xfc20ef2530ac5352b78f89434b188553cd08dad032344eadb94e48842661531d, @0xd292d7684e12431d1a1f765cae5d8b1dc5672bc356694efc30318d6015526309, @0x6c0ab37a950c958e6376dbf02e0fc2b18c32c3625d2c1f936a7b20e582743d7a, @0x5d2c08c16ad897c2a7591dd9cac450b36745e504d1d0043febd9fe74b84f311, @0xefc32b0e65091b05b627c2fa6b1e563bb4e5e94348dc34849a2d1bdc9dd34c7b, @0x740f6eecb164cf007847d2f39ea91194fc7b6601f6c263a2f395a3f6a5d247c3, @0xfe03d88dadd1384370468bb2207a5b39ef53be65c3d45d6df172c75138f347b6, @0x82279544c25da57a60ede75fdd39d4a14fb10480f0c264416c34bcad902ac0f3, @0xe11f02a5322446e32ae414bab6bcb4c3f1fcb17dcb7cee6cd07694a14a254ed6, @0x1643e317fbd6377238cd047deda7cd6cf2eb147b565e67369051f1c5cf721fc0, @0xc07015917bd72f2e7c48d5f4a04907a16dbc5400d9c3ed36cc1e2f623cb29791, @0x968c89e5e4aafbd2b408589e75e396f8bb8b4931803affba889e2e1f5fdc3d77, @0x277cfbf25018cf1e717b5ee624d0b751bde9d38f63370f75ff23adb3f55519a3, @0x67eb61c77f4ac7d80ae3943f21091c0e209c0808a667ab4a7492901ca03aaba0, @0xb1a331251f245df82d90b7d033939218444fdccdea897f6deaf2a49799d32fcb, @0x3e53f4d94793aba0702205e54cc079f6c68c469b472e1dccc761f1f142f99450, @0x750c21b9c711268bb2e49c8ff4b141eb50c39237522865868a9775cc085f622a, @0x3d219c14a4e47e061b356ad24974d9db2436bb27c870e907620efb777439b21e, @0x29e936dc18a82c6a3d5c9ecd813a8469ac1f99f228715c5381774ae35cc0104e, @0xbb880ef3ae394a0a1dcd3fdb095f1b536474bb81140d1f1bd26b4794d6521bc8, @0xbf70e2d3ffbc0d8d07894b63dcdc6c2ba96a757111a3f8c695f7195f41e0d317, @0x9529b794680923b068aea12effe663261c84728f3cc78111033719ef34756d0c, @0xc74b1d15582b90423f0e2ddb21cfd9f4989b54e75c473b75d326a6a3356e0716, @0x34902f9b467332baf5f9ad8e34f559c50a19e3c38922c793dd202d812b31ff78, @0x4a48305e78382015bc647fbf62df12ddd14950b9b65c6b67df9224092f34f542, @0x946b5fbf53f41bd5c359ff32ce2a3eddab1a3e5aff0a3d1fd5c004ec0d25ea07, @0xe63d1c520bf1fe9d59e5ad09e8b1b77d743e69a647b760482483d69c7a9246ff, @0xadb5983fc34146257d8411ed194ccbf16faf1986ddd869b8ce4e57227b0d502f, @0x218f659ca89d37d882902545b4fc8bb60ca3b08507a6a0efcb4b599283865683, @0x5f62b97222ac3f26da5ec32afc80f54715706a0c1eb88d1e96d806322bba4e5e, @0xde70d84d165d6554c2eca8087289aec17a1062e5e5660dbd78ae92eef7b8e1b9, @0x42000db2c5c1658dab33407986eb8710086952c73d958592984275a7e932bab1];
            let v1 = 0x2::tx_context::sender(arg2);
            assert!(0x1::vector::contains<address>(&v0, &v1), 0);
            0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::addWhitelistAddress(arg0, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getWhiteListPrice(arg0) * 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getLaunchpadFee(arg0) / 100, arg2), 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getCreator(arg0));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0xf5bb0a4c972bbadba63a33973785b96ef9307f83ff797780177fe1bb85ab0df9::collection::getAdmin(arg0));
        };
        general_mint(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

