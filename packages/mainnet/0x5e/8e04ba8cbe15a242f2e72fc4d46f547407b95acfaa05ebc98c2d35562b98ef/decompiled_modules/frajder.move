module 0x5e8e04ba8cbe15a242f2e72fc4d46f547407b95acfaa05ebc98c2d35562b98ef::frajder {
    struct FRAJDER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct TreasuryVault has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<FRAJDER>,
    }

    struct Drop has key {
        id: 0x2::object::UID,
        minted: vector<bool>,
        proceeds: 0x2::balance::Balance<FRAJDER>,
    }

    struct Pet has store, key {
        id: 0x2::object::UID,
        catalog_id: u64,
        role: PetRole,
        name: vector<u8>,
        image_url: vector<u8>,
        metadata_url: vector<u8>,
    }

    struct PetRole has copy, drop, store {
        value: u8,
    }

    public fun value(arg0: PetRole) : u8 {
        arg0.value
    }

    public fun admin_role() : PetRole {
        PetRole{value: 3}
    }

    public fun assign_role(arg0: &AdminCap, arg1: &mut Pet, arg2: PetRole, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = member_role();
        assert!(arg2.value != v0.value, 4);
        arg1.role = arg2;
    }

    fun create(arg0: FRAJDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FRAJDER>(arg0, 8, b"FRAJDER", b"FRAJDER", b"Frajder profile and pet utility token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRAJDER>>(v2);
        let v4 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<AdminCap>(v4, v0);
        let v5 = TreasuryVault{
            id       : 0x2::object::new(arg1),
            treasury : v3,
        };
        0x2::transfer::transfer<TreasuryVault>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FRAJDER>>(0x2::coin::mint<FRAJDER>(&mut v3, 888888888800000000, arg1), v0);
        let v6 = Drop{
            id       : 0x2::object::new(arg1),
            minted   : vector[false, false, false, false, false, false, false, false],
            proceeds : 0x2::balance::zero<FRAJDER>(),
        };
        0x2::transfer::share_object<Drop>(v6);
    }

    public fun decimals() : u8 {
        8
    }

    fun init(arg0: FRAJDER, arg1: &mut 0x2::tx_context::TxContext) {
        create(arg0, arg1);
    }

    public fun initial_supply() : u64 {
        888888888800000000
    }

    public fun member_role() : PetRole {
        PetRole{value: 0}
    }

    public fun mint_pet(arg0: &mut Drop, arg1: u64, arg2: 0x2::coin::Coin<FRAJDER>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 8, 1);
        let v0 = arg1 - 1;
        assert!(!*0x1::vector::borrow<bool>(&arg0.minted, v0), 2);
        assert!(0x2::coin::value<FRAJDER>(&arg2) == 88800000000, 3);
        0x2::balance::join<FRAJDER>(&mut arg0.proceeds, 0x2::coin::into_balance<FRAJDER>(arg2));
        *0x1::vector::borrow_mut<bool>(&mut arg0.minted, v0) = true;
        let v1 = Pet{
            id           : 0x2::object::new(arg3),
            catalog_id   : arg1,
            role         : pet_owner_role(),
            name         : pet_name(arg1),
            image_url    : pet_image_url(arg1),
            metadata_url : pet_metadata_url(arg1),
        };
        0x2::transfer::transfer<Pet>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun mint_price() : u64 {
        88800000000
    }

    public fun moderator_role() : PetRole {
        PetRole{value: 2}
    }

    public fun pet_catalog_id(arg0: &Pet) : u64 {
        arg0.catalog_id
    }

    fun pet_image_url(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/1.svg"
        } else if (arg0 == 2) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/2.svg"
        } else if (arg0 == 3) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/3.svg"
        } else if (arg0 == 4) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/4.svg"
        } else if (arg0 == 5) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/5.svg"
        } else if (arg0 == 6) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/6.svg"
        } else if (arg0 == 7) {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/7.svg"
        } else {
            b"ipfs://QmXf8HFanFv7GSX8ayveTrbRPcDB2371PdKb4affPBrGXG/images/8.svg"
        }
    }

    fun pet_metadata_url(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/1.json"
        } else if (arg0 == 2) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/2.json"
        } else if (arg0 == 3) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/3.json"
        } else if (arg0 == 4) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/4.json"
        } else if (arg0 == 5) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/5.json"
        } else if (arg0 == 6) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/6.json"
        } else if (arg0 == 7) {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/7.json"
        } else {
            b"ipfs://QmZKmPEJmwyki1mwU8BaMBSiVbJdMLnVLqjaXCq8uqLFF6/metadata/8.json"
        }
    }

    fun pet_name(arg0: u64) : vector<u8> {
        if (arg0 == 1) {
            b"Frajder Mint"
        } else if (arg0 == 2) {
            b"Frajder Glint"
        } else if (arg0 == 3) {
            b"Frajder Base"
        } else if (arg0 == 4) {
            b"Frajder Sui"
        } else if (arg0 == 5) {
            b"Frajder Node"
        } else if (arg0 == 6) {
            b"Frajder Signal"
        } else if (arg0 == 7) {
            b"Frajder Prism"
        } else {
            b"Frajder Crown"
        }
    }

    public fun pet_owner_role() : PetRole {
        PetRole{value: 1}
    }

    public fun pet_role(arg0: &Pet) : PetRole {
        arg0.role
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Drop, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FRAJDER>>(0x2::coin::from_balance<FRAJDER>(0x2::balance::withdraw_all<FRAJDER>(&mut arg1.proceeds), arg2), v0);
    }

    // decompiled from Move bytecode v7
}

