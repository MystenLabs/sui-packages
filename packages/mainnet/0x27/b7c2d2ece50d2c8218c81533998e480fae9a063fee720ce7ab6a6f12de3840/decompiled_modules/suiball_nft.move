module 0x27b7c2d2ece50d2c8218c81533998e480fae9a063fee720ce7ab6a6f12de3840::suiball_nft {
    struct SuiballNFT has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ItemStore has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        counter: u64,
        price: u64,
    }

    struct StoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUIBALL_NFT has drop {
        dummy_field: bool,
    }

    public entry fun collect_profits(arg0: &StoreOwnerCap, arg1: &mut ItemStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::sui::transfer(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun get_owner(arg0: &SuiballNFT) : address {
        arg0.owner
    }

    fun init(arg0: SUIBALL_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suiball"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://raw.githubusercontent.com/make-green-world/token-list/refs/heads/main/suiball-nft.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"4e465420726563656976656420666f72205072652d4f72646572696e672053756962616c6c2048617264776172652057616c6c65742e204e46542077696c6c206265207573656420746f20636c61696d207468652068617264776172652077616c6c6574732e0a576562736974653a2053756962616c6c2e636f6d"));
        let v4 = 0x2::package::claim<SUIBALL_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiballNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiballNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiballNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ItemStore{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            counter : 0,
            price   : 1000000,
        };
        0x2::transfer::share_object<ItemStore>(v6);
        let v7 = StoreOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<StoreOwnerCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun is_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    public entry fun mint_to_sender(arg0: &mut ItemStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.counter < 10000, 1);
        assert!(arg2 > 0, 2);
        assert!(arg2 < 11, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price * arg2, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = 0;
        let v1 = 0x2::tx_context::sender(arg3);
        loop {
            let v2 = SuiballNFT{
                id    : 0x2::object::new(arg3),
                owner : v1,
            };
            arg0.counter = arg0.counter + 1;
            0x2::transfer::transfer<SuiballNFT>(v2, v1);
            v0 = v0 + 1;
            if (v0 == arg2) {
                break
            };
        };
    }

    public entry fun set_price(arg0: &StoreOwnerCap, arg1: &mut ItemStore, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    public fun verify_owner(arg0: &SuiballNFT, arg1: address) : bool {
        arg0.owner == arg1
    }

    // decompiled from Move bytecode v6
}

