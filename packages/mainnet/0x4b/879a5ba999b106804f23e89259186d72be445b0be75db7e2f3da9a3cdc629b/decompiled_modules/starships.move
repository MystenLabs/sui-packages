module 0x4b879a5ba999b106804f23e89259186d72be445b0be75db7e2f3da9a3cdc629b::starships {
    struct Captain has store, key {
        id: 0x2::object::UID,
    }

    struct MetaData has key {
        id: 0x2::object::UID,
        maxSupply: u64,
        minted: u64,
        mintFee: u64,
        url: 0x1::string::String,
        mintingEnabled: bool,
        owner: address,
        mintedAddresses: vector<address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Starship has store, key {
        id: 0x2::object::UID,
        index: u64,
        speed: u64,
        level: u64,
        milestone: u64,
        url: 0x1::string::String,
        owner: address,
        position: address,
    }

    struct Encounter has store, key {
        id: 0x2::object::UID,
        status: u64,
        starshipAddresses: vector<address>,
        record: vector<BattleDetails>,
    }

    struct BattleDetails has copy, drop, store {
        time: u64,
        attacker: address,
        defender: address,
        damage: u64,
    }

    public fun Starshipspeed(arg0: &Starship) : u64 {
        arg0.speed
    }

    fun burnNFT(arg0: Starship) {
        let Starship {
            id        : v0,
            index     : _,
            speed     : _,
            level     : _,
            milestone : _,
            url       : _,
            owner     : _,
            position  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun changeMintFee(arg0: &mut MetaData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.mintFee = arg1;
    }

    fun imgUrl(arg0: u64) : 0x1::string::String {
        let v0 = b"https://ipfs.io/ipfs/QmZXRFdZJ9xaSFXioD3mjL9YnjAxPdfZXrxYXBXGNZfp8F/";
        let v1 = v0;
        0x1::vector::append<u8>(&mut v1, numStr(arg0 % 100 + 1));
        0x1::vector::append<u8>(&mut v1, b".png");
        0x1::string::utf8(v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Captain{id: 0x2::object::new(arg0)};
        let v1 = MetaData{
            id              : 0x2::object::new(arg0),
            maxSupply       : 10000,
            minted          : 0,
            mintFee         : 1000000000,
            url             : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmZXRFdZJ9xaSFXioD3mjL9YnjAxPdfZXrxYXBXGNZfp8F/0.gif"),
            mintingEnabled  : true,
            owner           : 0x2::tx_context::sender(arg0),
            mintedAddresses : 0x1::vector::empty<address>(),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MetaData>(v1);
        0x2::transfer::public_transfer<Captain>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun mint(arg0: &mut MetaData, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mintingEnabled, 0);
        assert!(arg0.minted < arg0.maxSupply, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = randArrayGenerator(0x2::object::uid_to_bytes(&v1));
        let v3 = Starship{
            id        : v1,
            index     : arg0.minted,
            speed     : (*0x1::vector::borrow<u8>(&v2, 0) as u64) * 2,
            level     : 1,
            milestone : 0,
            url       : imgUrl(arg0.minted),
            owner     : v0,
            position  : @0x0,
        };
        arg0.minted = arg0.minted + 1;
        0x1::vector::push_back<address>(&mut arg0.mintedAddresses, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg0.mintFee), arg2), arg0.owner);
        0x2::transfer::public_transfer<Starship>(v3, v0);
    }

    entry fun mintswitch(arg0: &mut MetaData, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(&arg0.owner == &v0, 0);
        arg0.mintingEnabled = !arg0.mintingEnabled;
    }

    entry fun mixture(arg0: &mut MetaData, arg1: Starship, arg2: Starship, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.level == arg2.level, 0);
        assert!(arg1.milestone == arg2.milestone, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Starship{
            id        : 0x2::object::new(arg4),
            index     : arg0.minted,
            speed     : arg1.speed + arg2.speed,
            level     : arg1.level + 1,
            milestone : 0,
            url       : imgUrl(arg0.minted),
            owner     : v0,
            position  : @0x0,
        };
        burnNFT(arg1);
        burnNFT(arg2);
        0x1::vector::push_back<address>(&mut arg0.mintedAddresses, v0);
        0x2::transfer::public_transfer<Starship>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg0.mintFee), arg4), arg0.owner);
    }

    fun numStr(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 100 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 100 + 48) as u8));
            arg0 = arg0 / 100;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun randArrayGenerator(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    entry fun transferStarship(arg0: Starship, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.position == @0x0, 0);
        0x2::transfer::public_transfer<Starship>(arg0, arg1);
    }

    public fun url(arg0: &Starship) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

