module 0x2b81fe886cc3a1bb0de5c25fa18020013159120e43fa9bb45ce4a30f0d196a90::pfp_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        tokenId: u64,
        name: 0x1::string::String,
        type: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        link: 0x2::url::Url,
        metadata: 0x2::url::Url,
    }

    struct PFP_NFT has drop {
        dummy_field: bool,
    }

    struct Owner has copy, drop, store {
        tokenId: u64,
        owner: address,
    }

    struct Minted has copy, drop {
        id: 0x2::object::ID,
        to: address,
        tokenId: u64,
        name: 0x1::string::String,
        uri: 0x2::url::Url,
        image: 0x2::url::Url,
        mimeType: 0x1::string::String,
        timestamp: u64,
    }

    struct MintHistory has copy, drop, store {
        to: address,
        tokenId: u64,
        name: 0x1::string::String,
        uri: 0x2::url::Url,
        image: 0x2::url::Url,
        mimeType: 0x1::string::String,
        timestamp: u64,
    }

    struct SettingCap has key {
        id: 0x2::object::UID,
        owner: address,
        holder: address,
        minters: vector<address>,
        dev: address,
        price: u64,
        passNft: address,
        devPercent: u64,
        idCounter: u64,
        history: vector<MintHistory>,
        uris: vector<0x2::url::Url>,
        owners: vector<Owner>,
    }

    public entry fun transfer(arg0: NFT, arg1: address, arg2: &mut SettingCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            if (v0 > arg2.idCounter) {
                break
            };
            let v1 = 0x1::vector::borrow_mut<Owner>(&mut arg2.owners, v0);
            if (v1.owner == 0x2::tx_context::sender(arg3)) {
                let v2 = Owner{
                    tokenId : v0,
                    owner   : arg1,
                };
                *v1 = v2;
            };
            v0 = v0 + 1;
        };
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    public fun get_all_tokens(arg0: &mut SettingCap, arg1: address) : vector<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        loop {
            if (v0 > arg0.idCounter) {
                break
            };
            if (0x1::vector::borrow<Owner>(&arg0.owners, v0).owner == arg1) {
                0x1::vector::push_back<u64>(&mut v1, v0);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_history(arg0: &SettingCap) : vector<MintHistory> {
        arg0.history
    }

    fun init(arg0: PFP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SettingCap{
            id         : 0x2::object::new(arg1),
            owner      : 0x2::tx_context::sender(arg1),
            holder     : 0x2::tx_context::sender(arg1),
            minters    : vector[],
            dev        : 0x2::tx_context::sender(arg1),
            price      : 0,
            passNft    : @0x0,
            devPercent : 1000,
            idCounter  : 0,
            history    : 0x1::vector::empty<MintHistory>(),
            uris       : 0x1::vector::empty<0x2::url::Url>(),
            owners     : 0x1::vector::empty<Owner>(),
        };
        0x2::transfer::share_object<SettingCap>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{link}"));
        let v5 = 0x2::package::claim<PFP_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut SettingCap, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 13);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = arg8.price * arg6;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == v1, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v1 * arg8.devPercent / 10000, arg9), arg8.dev);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, arg8.holder);
        let v2 = 0;
        loop {
            if (v2 == arg6) {
                break
            };
            let v3 = NFT{
                id          : 0x2::object::new(arg9),
                tokenId     : arg8.idCounter + v2,
                name        : 0x1::string::utf8(arg0),
                type        : 0x1::string::utf8(arg1),
                description : 0x1::string::utf8(arg2),
                url         : 0x2::url::new_unsafe_from_bytes(arg3),
                image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
                link        : 0x2::url::new_unsafe_from_bytes(arg4),
                metadata    : 0x2::url::new_unsafe_from_bytes(arg5),
            };
            let v4 = Minted{
                id        : 0x2::object::uid_to_inner(&v3.id),
                to        : v0,
                tokenId   : v3.tokenId,
                name      : v3.name,
                uri       : v3.url,
                image     : v3.link,
                mimeType  : v3.type,
                timestamp : 0x2::tx_context::epoch(arg9),
            };
            0x2::event::emit<Minted>(v4);
            let v5 = MintHistory{
                to        : v0,
                tokenId   : v3.tokenId,
                name      : v3.name,
                uri       : v3.url,
                image     : v3.link,
                mimeType  : v3.type,
                timestamp : 0x2::tx_context::epoch(arg9),
            };
            0x1::vector::push_back<MintHistory>(&mut arg8.history, v5);
            0x1::vector::push_back<0x2::url::Url>(&mut arg8.uris, v3.url);
            let v6 = Owner{
                tokenId : v3.tokenId,
                owner   : v0,
            };
            0x1::vector::push_back<Owner>(&mut arg8.owners, v6);
            0x2::transfer::public_transfer<NFT>(v3, v0);
            v2 = v2 + 1;
        };
        arg8.idCounter = arg8.idCounter + v2;
    }

    public entry fun set_dev_percent(arg0: u64, arg1: &mut SettingCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        arg1.devPercent = arg0;
    }

    public entry fun set_dev_wallet(arg0: address, arg1: &mut SettingCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        arg1.dev = arg0;
    }

    public entry fun set_minter(arg0: address, arg1: bool, arg2: &mut SettingCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.owner == 0x2::tx_context::sender(arg3), 12);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg2.minters, &arg0);
        if (v0 == true && arg1 == false) {
            0x1::vector::remove<address>(&mut arg2.minters, v1);
        };
        if (v0 == false && arg1 == true) {
            0x1::vector::push_back<address>(&mut arg2.minters, arg0);
        };
    }

    public entry fun set_owner_wallet(arg0: address, arg1: &mut SettingCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        arg1.holder = arg0;
    }

    public entry fun set_pass_nft(arg0: address, arg1: &mut SettingCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        arg1.passNft = arg0;
    }

    public entry fun set_price(arg0: u64, arg1: &mut SettingCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        arg1.price = arg0;
    }

    public entry fun set_token_uri(arg0: u64, arg1: vector<u8>, arg2: &mut SettingCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.owner == 0x2::tx_context::sender(arg3), 12);
        *0x1::vector::borrow_mut<0x2::url::Url>(&mut arg2.uris, arg0) = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun token_uri(arg0: &mut SettingCap, arg1: u64) : &0x2::url::Url {
        0x1::vector::borrow<0x2::url::Url>(&arg0.uris, arg1)
    }

    public entry fun transfer_ownership(arg0: address, arg1: &mut SettingCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 12);
        arg1.owner = arg0;
    }

    // decompiled from Move bytecode v6
}

