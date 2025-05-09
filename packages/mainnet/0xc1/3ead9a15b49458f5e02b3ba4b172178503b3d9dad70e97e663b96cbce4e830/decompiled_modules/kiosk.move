module 0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    struct PolicyInfo has store, key {
        id: 0x2::object::UID,
        authority: address,
    }

    public(friend) fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft) {
        0x2::kiosk::place<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1, arg2);
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>, arg1: 0x2::transfer_policy::TransferRequest<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>) : (0x2::object::ID, u64, 0x2::object::ID) {
        0x2::transfer_policy::confirm_request<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1)
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft, 0x2::transfer_policy::TransferRequest<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>) {
        0x2::kiosk::purchase<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1, arg2)
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = new_policy(&v0, arg1);
        let v4 = PolicyInfo{
            id        : 0x2::object::new(arg1),
            authority : v1,
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>>(v2);
        0x2::transfer::public_share_object<PolicyInfo>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>>(v3, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public(friend) fun new_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun new_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>, 0x2::transfer_policy::TransferPolicyCap<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>) {
        let (v0, v1) = 0x2::transfer_policy::new<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::royalty_rule::add<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(&mut v3, &v2, 500);
        (v3, v2)
    }

    public(friend) fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft {
        0x2::kiosk::take<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1, arg2)
    }

    public entry fun withdraw_royalty_proceeds(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>, arg2: &PolicyInfo, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.authority, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::royalty_rule::withdraw<0xc13ead9a15b49458f5e02b3ba4b172178503b3d9dad70e97e663b96cbce4e830::nft::Nft>(arg0, arg1, 0x1::option::none<u64>(), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

