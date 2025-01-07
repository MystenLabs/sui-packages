module 0x1b66c2d0ea861799b2e55bb33b385f8e7a857a8a556ed70bd0e425cd862a0c4a::snailmail {
    struct SnailMailNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct SnailMailNFTMaintainer has key {
        id: 0x2::object::UID,
        maintainer_address: address,
        mail_count: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SNAILMAIL has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun transfer(arg0: SnailMailNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SnailMailNFT>(arg0, arg1);
    }

    public entry fun burn(arg0: SnailMailNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SnailMailNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun change_fee(arg0: &mut SnailMailNFTMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.fee = arg1;
    }

    public entry fun change_maintainer(arg0: &mut SnailMailNFTMaintainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.maintainer_address = arg1;
    }

    public fun description(arg0: &SnailMailNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SnailMailNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SNAILMAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<SNAILMAIL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SnailMailNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SnailMailNFT>(&mut v5);
        let v6 = SnailMailNFTMaintainer{
            id                 : 0x2::object::new(arg1),
            maintainer_address : 0x2::tx_context::sender(arg1),
            mail_count         : 0,
            fee                : 20000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SnailMailNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<SnailMailNFTMaintainer>(v6);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg1, v1);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public entry fun mint_to_recipient(arg0: &mut SnailMailNFTMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = merge_and_split(arg1, arg0.fee, arg6);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg6));
        let v2 = SnailMailNFT{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v3 = NFTMinted{
            object_id   : 0x2::object::id<SnailMailNFT>(&v2),
            creator     : 0x2::tx_context::sender(arg6),
            name        : v2.name,
            description : v2.description,
        };
        0x2::event::emit<NFTMinted>(v3);
        arg0.mail_count = arg0.mail_count + 1;
        0x2::transfer::transfer<SnailMailNFT>(v2, arg5);
    }

    public fun name(arg0: &SnailMailNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun pay_maintainer(arg0: &mut SnailMailNFTMaintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maintainer_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

