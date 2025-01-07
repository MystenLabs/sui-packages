module 0x138a2f2c14aaacfa5724e9295de5a000147bf9697f17c085e76b19749e1e7a83::PEPESEGG {
    struct PepeEggStorage has key {
        id: 0x2::object::UID,
        supply: u64,
        minters: 0x2::vec_set::VecSet<0x2::object::ID>,
        img_url: 0x2::url::Url,
        issued_counter: u64,
    }

    struct PepeEggNFT has store, key {
        id: 0x2::object::UID,
        n: u64,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct PepeEggAdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        n: u64,
    }

    struct MinterAdded has copy, drop {
        id: 0x2::object::ID,
    }

    struct MinterRemoved has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewAdmin has copy, drop {
        admin: address,
    }

    public entry fun transfer(arg0: PepeEggNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PepeEggNFT>(arg0, arg1);
    }

    public fun url(arg0: &PepeEggNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun add_minter(arg0: &PepeEggAdminCap, arg1: &mut PepeEggStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.minters, arg2);
        let v0 = MinterAdded{id: arg2};
        0x2::event::emit<MinterAdded>(v0);
    }

    public entry fun burn(arg0: PepeEggNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let PepeEggNFT {
            id          : v0,
            n           : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PepeEggNFT) : &0x1::string::String {
        &arg0.description
    }

    fun img_url() : 0x2::url::Url {
        let v0 = b"https://i.imgur.com/mDxntB2.png";
        0x2::url::new_unsafe_from_bytes(v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PepeEggAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PepeEggAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PepeEggStorage{
            id             : 0x2::object::new(arg0),
            supply         : 10000,
            minters        : 0x2::vec_set::empty<0x2::object::ID>(),
            img_url        : img_url(),
            issued_counter : 0,
        };
        0x2::transfer::share_object<PepeEggStorage>(v1);
    }

    public fun is_minter(arg0: &PepeEggStorage, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.minters, &arg1)
    }

    public entry fun mint_egg(arg0: &mut PepeEggStorage, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_minter(arg0, 0x2::object::id<0x2::package::Publisher>(arg1)), 1);
        let v0 = arg0.issued_counter;
        assert!(v0 <= arg0.supply, 2);
        arg0.issued_counter = v0 + 1;
        let v1 = PepeEggNFT{
            id          : 0x2::object::new(arg3),
            n           : v0,
            description : 0x1::string::utf8(b"Pepe Sui Egg NFT Collection"),
            url         : arg0.img_url,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<PepeEggNFT>(&v1),
            creator   : arg2,
            n         : v0,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<PepeEggNFT>(v1, arg2);
    }

    public entry fun remove_minter(arg0: &PepeEggAdminCap, arg1: &mut PepeEggStorage, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.minters, &arg2);
        let v0 = MinterRemoved{id: arg2};
        0x2::event::emit<MinterRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

