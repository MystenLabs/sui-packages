module 0x3c9701fad6bb33f297f4d6a3943c7f483d14cea44d1ed08a2fe885d802d47648::nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        signer: vector<u8>,
        package: address,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        class: u8,
        rarity: u8,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<Item>(arg0, arg1, arg2, arg3);
    }

    public entry fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: Item) {
        0x2::kiosk::place<Item>(arg0, arg1, arg2);
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<Item>, arg1: 0x2::transfer_policy::TransferRequest<Item>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Item>(arg0, arg1);
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : Item {
        0x2::kiosk::take<Item>(arg0, arg1, arg2)
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (Item, 0x2::transfer_policy::TransferRequest<Item>) {
        0x2::kiosk::purchase<Item>(arg0, arg1, arg2)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Storage{
            id      : 0x2::object::new(arg1),
            signer  : 0x1::vector::empty<u8>(),
            package : @0x0,
        };
        0x2::transfer::share_object<Storage>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"class"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"test name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"test description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmdBtsFn2y6gDkVkRnaQdymWn8h2qB2D2yNk7BcSjv3ZM3/992.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{class}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://google.com/"));
        let v6 = 0x2::package::claim<NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Item>(&v6, v2, v4, arg1);
        0x2::display::update_version<Item>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<Item>(&v6, arg1);
        let v10 = v9;
        let v11 = v8;
        0x3c9701fad6bb33f297f4d6a3943c7f483d14cea44d1ed08a2fe885d802d47648::royalty_policy::set<Item>(&mut v11, &v10, 200);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Item>>(v11);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Item>>(v10, 0x2::tx_context::sender(arg1));
        let (v12, v13) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v12);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v13, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: u8, arg1: u8, arg2: vector<u8>, arg3: &mut Storage, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(verifyMintSignature(arg3.package, 0x2::tx_context::sender(arg4), arg0, arg1, arg3.signer, arg2), 9223372487826669574);
        let v0 = Item{
            id     : 0x2::object::new(arg4),
            class  : arg0,
            rarity : arg1,
        };
        0x2::transfer::public_transfer<Item>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun updateStorage(arg0: address, arg1: vector<u8>, arg2: &mut Storage, arg3: &AdminCap) {
        arg2.package = arg0;
        arg2.signer = arg1;
    }

    fun verifyMintSignature(arg0: address, arg1: address, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"mint");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg0))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::address::to_bytes(arg1))));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x3c9701fad6bb33f297f4d6a3943c7f483d14cea44d1ed08a2fe885d802d47648::string::u8_to_string(arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x3c9701fad6bb33f297f4d6a3943c7f483d14cea44d1ed08a2fe885d802d47648::string::u8_to_string(arg3));
        0x2::ed25519::ed25519_verify(&arg5, &arg4, 0x1::string::as_bytes(&v0))
    }

    public fun withdraw_profit(arg0: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg1: &0x2::transfer_policy::TransferPolicyCap<Item>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x2::sui::SUI>(arg2, 0x2::transfer_policy::withdraw<Item>(arg0, arg1, 0x1::option::none<u64>(), arg3));
    }

    // decompiled from Move bytecode v6
}

