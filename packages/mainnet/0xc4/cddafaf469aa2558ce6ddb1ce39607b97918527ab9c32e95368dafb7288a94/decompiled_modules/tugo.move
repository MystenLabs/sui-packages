module 0xc4cddafaf469aa2558ce6ddb1ce39607b97918527ab9c32e95368dafb7288a94::tugo {
    struct TUGO has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        creator: address,
        idoMintedSupply: u64,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        minters: vector<address>,
        ido: IdoReserve,
    }

    struct IdoReserve has store {
        tugo: 0x2::balance::Balance<TUGO>,
    }

    struct Minter has key {
        id: 0x2::object::UID,
        minted: u64,
        address: address,
    }

    public fun changeCreator(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        arg0.creator = arg1;
    }

    public fun idoMintedSupply(arg0: &Registry) : u64 {
        arg0.idoMintedSupply
    }

    fun init(arg0: TUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TUGO>(arg0, 5, b"TUGO", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TUGO>(&mut v3, 10000000000000000 - 2700000000000000, v0, arg1);
        let v4 = IdoReserve{tugo: 0x2::balance::zero<TUGO>()};
        0x2::balance::join<TUGO>(&mut v4.tugo, 0x2::coin::mint_balance<TUGO>(&mut v3, 2700000000000000));
        let v5 = Registry{
            id              : 0x2::object::new(arg1),
            creator         : v0,
            idoMintedSupply : 0,
            sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            minters         : 0x1::vector::empty<address>(),
            ido             : v4,
        };
        0x2::transfer::share_object<Registry>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TUGO>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUGO>>(v2);
    }

    public fun initializeMinter(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.minters, &v0) == false, 6);
        0x1::vector::push_back<address>(&mut arg0.minters, v0);
        let v1 = Minter{
            id      : 0x2::object::new(arg1),
            minted  : 0,
            address : v0,
        };
        0x2::transfer::transfer<Minter>(v1, v0);
    }

    public fun maxSupply() : u64 {
        10000000000000000
    }

    public fun mint(arg0: &mut Registry, arg1: &mut Minter, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 2700000000000000 / 2;
        assert!(0x1::vector::contains<address>(&arg0.minters, &v0) == true, 7);
        assert!(arg0.idoMintedSupply + v1 >= 2700000000000000, 1);
        assert!(arg1.address == v0, 5);
        assert!(arg1.minted + v1 > 44999500, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<TUGO>>(0x2::coin::take<TUGO>(&mut arg0.ido.tugo, v1, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.creator);
        arg1.minted = arg1.minted + v1;
        arg0.idoMintedSupply = arg0.idoMintedSupply + v1;
    }

    public fun mintableSupply() : u64 {
        2700000000000000
    }

    public fun minters(arg0: &Registry) : &vector<address> {
        &arg0.minters
    }

    // decompiled from Move bytecode v6
}

