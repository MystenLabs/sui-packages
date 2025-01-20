module 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>, arg1: 0x2::transfer_policy::TransferRequest<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1);
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT, 0x2::transfer_policy::TransferRequest<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>) {
        0x2::kiosk::purchase<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1, arg2)
    }

    public fun create_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKETPLACE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let (v0, v1) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun place_and_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT, arg3: u64) {
        0x2::kiosk::place<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1, arg2);
        0x2::kiosk::list<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1, 0x2::object::id<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(&arg2), arg3);
    }

    public fun remove(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT {
        0x2::kiosk::take<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1, arg2)
    }

    public fun update_price(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::delist<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1, arg2);
        0x2::kiosk::list<0x5a3065e68f34808b4cac353272b7115ce588f1e97e0e18a70363ea044ba6998e::agent_nft::AGENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

