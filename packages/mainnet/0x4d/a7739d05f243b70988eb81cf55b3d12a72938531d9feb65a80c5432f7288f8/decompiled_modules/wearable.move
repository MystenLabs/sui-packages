module 0x4da7739d05f243b70988eb81cf55b3d12a72938531d9feb65a80c5432f7288f8::wearable {
    struct WEARABLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        n_mints: u64,
    }

    struct BurnPolicyWrapper has key {
        id: 0x2::object::UID,
        empty_transfer_policy: 0x2::transfer_policy::TransferPolicy<Wearable>,
    }

    struct RewardBox has key {
        id: 0x2::object::UID,
        wearable: Wearable,
    }

    struct Wearable has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        rarity: 0x1::string::String,
        supply: u32,
        level: u32,
        tags: vector<0x1::string::String>,
        slot: 0x1::string::String,
        wearable_appearance_id: 0x1::string::String,
    }

    struct RewardBoxUnwrapped has copy, drop {
        kiosk_id: 0x2::object::ID,
        wearable_id: 0x2::object::ID,
    }

    public fun admin_burn(arg0: &AdminCap, arg1: Wearable) {
        burn(arg1);
    }

    public fun admin_create_mint_cap(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{
            id      : 0x2::object::new(arg2),
            n_mints : arg1,
        }
    }

    public fun admin_transfer_mint_cap(arg0: &AdminCap, arg1: MintCap, arg2: address) {
        0x2::transfer::transfer<MintCap>(arg1, arg2);
    }

    fun burn(arg0: Wearable) {
        let Wearable {
            id                     : v0,
            name                   : _,
            description            : _,
            rarity                 : _,
            supply                 : _,
            level                  : _,
            tags                   : _,
            slot                   : _,
            wearable_appearance_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_mintcap(arg0: MintCap) {
        let MintCap {
            id      : v0,
            n_mints : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: WEARABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WEARABLE>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let (v2, v3) = 0x2::transfer_policy::new<Wearable>(&v0, arg1);
        let v4 = BurnPolicyWrapper{
            id                    : 0x2::object::new(arg1),
            empty_transfer_policy : v2,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<BurnPolicyWrapper>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Wearable>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer_wearables(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<address>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.n_mints;
        let v1 = 0x1::vector::length<address>(&arg9);
        let v2 = 0;
        assert!(*v0 >= v1, 0);
        *v0 = *v0 - v1;
        while (v2 < v1) {
            let v3 = Wearable{
                id                     : 0x2::object::new(arg10),
                name                   : arg1,
                description            : arg2,
                rarity                 : arg3,
                supply                 : arg4,
                level                  : arg5,
                tags                   : arg6,
                slot                   : arg7,
                wearable_appearance_id : arg8,
            };
            let v4 = RewardBox{
                id       : 0x2::object::new(arg10),
                wearable : v3,
            };
            0x2::transfer::transfer<RewardBox>(v4, 0x1::vector::pop_back<address>(&mut arg9));
            v2 = v2 + 1;
        };
    }

    public fun mint_wearable(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Wearable {
        let v0 = &mut arg0.n_mints;
        assert!(*v0 != 0, 0);
        *v0 = *v0 - 1;
        Wearable{
            id                     : 0x2::object::new(arg9),
            name                   : arg1,
            description            : arg2,
            rarity                 : arg3,
            supply                 : arg4,
            level                  : arg5,
            tags                   : arg6,
            slot                   : arg7,
            wearable_appearance_id : arg8,
        }
    }

    public fun minter_burn(arg0: &MintCap, arg1: Wearable) {
        burn(arg1);
    }

    public fun send_wearable_in_reward_box(arg0: Wearable, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardBox{
            id       : 0x2::object::new(arg2),
            wearable : arg0,
        };
        0x2::transfer::transfer<RewardBox>(v0, arg1);
    }

    public fun unwrap_reward_box(arg0: RewardBox, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<Wearable>) {
        let RewardBox {
            id       : v0,
            wearable : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        0x2::kiosk::lock<Wearable>(arg1, arg2, arg3, v2);
        let v3 = RewardBoxUnwrapped{
            kiosk_id    : 0x2::object::uid_to_inner(0x2::kiosk::uid(arg1)),
            wearable_id : 0x2::object::uid_to_inner(&v2.id),
        };
        0x2::event::emit<RewardBoxUnwrapped>(v3);
    }

    public fun user_burn(arg0: &BurnPolicyWrapper, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<Wearable>(arg2, 0x2::kiosk::list_with_purchase_cap<Wearable>(arg2, arg1, arg3, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Wearable>(&arg0.empty_transfer_policy, v1);
        burn(v0);
    }

    // decompiled from Move bytecode v6
}

