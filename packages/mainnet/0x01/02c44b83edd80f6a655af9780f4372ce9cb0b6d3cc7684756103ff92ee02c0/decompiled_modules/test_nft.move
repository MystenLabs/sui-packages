module 0x102c44b83edd80f6a655af9780f4372ce9cb0b6d3cc7684756103ff92ee02c0::test_nft {
    struct TEST_NFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        kiosk_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{id: 0x2::object::new(arg0)}
    }

    public fun burn(arg0: NFT) {
        let NFT { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit_to_vault(arg0: &Vault, arg1: &0x2::transfer_policy::TransferPolicy<NFT>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<NFT> {
        0x2::kiosk::list<NFT>(arg4, arg5, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<NFT>(arg4, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<NFT>(arg2, &arg0.kiosk_cap, arg1, v0);
        v1
    }

    fun init(arg0: TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TEST_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x102c44b83edd80f6a655af9780f4372ce9cb0b6d3cc7684756103ff92ee02c0::royalty_rule::add<NFT>(&mut v4, &v3, 600, 0);
        0x102c44b83edd80f6a655af9780f4372ce9cb0b6d3cc7684756103ff92ee02c0::kiosk_lock_rule::add<NFT>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v3, 0x2::tx_context::sender(arg1));
        let (v5, v6) = 0x2::kiosk::new(arg1);
        let v7 = v5;
        let v8 = Vault{
            id        : 0x2::object::new(arg1),
            kiosk_cap : v6,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v7),
        };
        0x2::transfer::public_share_object<Vault>(v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
    }

    public fun withdraw_from_vault(arg0: &Vault, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (NFT, 0x2::transfer_policy::TransferRequest<NFT>) {
        0x2::kiosk::list<NFT>(arg1, &arg0.kiosk_cap, arg2, 0);
        0x2::kiosk::purchase<NFT>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    // decompiled from Move bytecode v6
}

