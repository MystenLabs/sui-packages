module 0x3abfe5e30c31d973334af1b4bebb308d37bba89b4e3c290fda8fcf9d302873e3::splo_on_sui {
    struct SPLO_ON_SUI has drop {
        dummy_field: bool,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        display: 0x2::display::Display<Nft>,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<Nft>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reserved_nft_ids: vector<0x2::object::ID>,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        group_id: 0x1::string::String,
        type: u64,
        name: 0x1::string::String,
        index: u64,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        group_id: 0x1::string::String,
        type: u64,
        index: u64,
        order_id: 0x1::string::String,
        stage_id: 0x1::string::String,
        is_autoreserve: bool,
        price: u64,
        collection_id: 0x1::string::String,
        collection_creator_wallet: address,
        manager_id: 0x2::object::ID,
    }

    struct AddNftMetadataEvent has copy, drop {
        group_id: 0x1::string::String,
        type: u64,
        index: u64,
        collection_id: 0x1::string::String,
    }

    struct CreateCollectionEvent has copy, drop {
        publisher_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        transfer_policy_id: 0x2::object::ID,
        collection_id: 0x1::string::String,
    }

    struct UpdateNftEvent has copy, drop {
        id: 0x2::object::ID,
        collection_id: 0x1::string::String,
    }

    public entry fun add_nft_metadata(arg0: &0x2::package::Publisher, arg1: &mut 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::Store, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public fun create_nft_with_verification(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = Nft{
            id          : 0x2::object::new(arg6),
            group_id    : 0x1::string::utf8(b""),
            type        : 0,
            name        : arg0,
            index       : 0,
            description : arg1,
            media_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        };
        0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::set_verification_nft_id(arg5, 0x2::object::id<Nft>(&v0));
        v0
    }

    public fun display_mut(arg0: &0x2::package::Publisher, arg1: &mut Manager) : &mut 0x2::display::Display<Nft> {
        abort 2
    }

    fun init(arg0: SPLO_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public entry fun mint_nft(arg0: &0x2::clock::Clock, arg1: &mut Manager, arg2: &mut 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::Store, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::kiosk::Kiosk, arg14: &0x2::kiosk::KioskOwnerCap, arg15: &0x2::transfer_policy::TransferPolicy<Nft>, arg16: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public fun package_version() : u64 {
        3
    }

    public fun policy_cap(arg0: &0x2::package::Publisher, arg1: &Manager) : &0x2::transfer_policy::TransferPolicyCap<Nft> {
        abort 2
    }

    public entry fun update_nft(arg0: &0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::Store, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public fun update_nft_with_verification(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::get_verification_nft_id(arg6) == arg0, 2);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg7, arg8, arg0);
        v0.name = arg1;
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
    }

    public fun version(arg0: &Manager) : u64 {
        3
    }

    public entry fun withdraw_balance(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public entry fun withdraw_reserved_nfts(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Nft>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public entry fun withdraw_royalties(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    // decompiled from Move bytecode v6
}

