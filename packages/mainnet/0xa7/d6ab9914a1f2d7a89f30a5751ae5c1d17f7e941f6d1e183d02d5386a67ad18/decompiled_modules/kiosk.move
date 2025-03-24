module 0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::kiosk {
    struct KIOSK has drop {
        dummy_field: bool,
    }

    public(friend) fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft) {
        0x2::kiosk::place<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(arg0, arg1, arg2);
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>, arg1: 0x2::transfer_policy::TransferRequest<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>) : (0x2::object::ID, u64, 0x2::object::ID) {
        0x2::transfer_policy::confirm_request<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(arg0, arg1)
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft, 0x2::transfer_policy::TransferRequest<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>) {
        0x2::kiosk::purchase<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(arg0, arg1, arg2)
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK>(arg0, arg1);
        let (v1, v2) = new_policy(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun new_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>, 0x2::transfer_policy::TransferPolicyCap<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>) {
        let (v0, v1) = 0x2::transfer_policy::new<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::royalty_rule::add<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(&mut v3, &v2, 500);
        (v3, v2)
    }

    public(friend) fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft {
        0x2::kiosk::take<0xa7d6ab9914a1f2d7a89f30a5751ae5c1d17f7e941f6d1e183d02d5386a67ad18::nft::Nft>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

