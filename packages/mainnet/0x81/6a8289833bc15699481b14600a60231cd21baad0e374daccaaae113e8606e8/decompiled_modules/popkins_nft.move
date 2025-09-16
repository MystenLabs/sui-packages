module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::popkins_nft {
    struct POPKINS_NFT has drop {
        dummy_field: bool,
    }

    struct Popkins has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        avatar_url: 0x1::string::String,
        avatar_thumb_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct PopkinsRegistryPolicy has store, key {
        id: 0x2::object::UID,
        version: u8,
        empty_policy: 0x2::transfer_policy::TransferPolicy<Popkins>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Popkins>,
    }

    struct PopkinsMinted has copy, drop {
        popkins_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct PopkinsTransferred has copy, drop {
        popkins_id: 0x2::object::ID,
        new_owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct PopkinsBurned has copy, drop {
        popkins_id: 0x2::object::ID,
        key: 0x1::string::String,
    }

    public fun transfer(arg0: &mut PopkinsRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<Popkins>, arg4: 0x2::object::ID, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        validate_popkins_registry_policy_version(arg0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<Popkins>(arg1, 0x2::kiosk::list_with_purchase_cap<Popkins>(arg1, arg2, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Popkins>(&arg0.empty_policy, v1);
        let (v6, v7) = 0x2::kiosk::new(arg6);
        let v8 = v7;
        let v9 = v6;
        0x2::kiosk::lock<Popkins>(&mut v9, &v8, arg3, v2);
        let v10 = PopkinsTransferred{
            popkins_id : 0x2::object::uid_to_inner(&v2.id),
            new_owner  : arg5,
            kiosk_id   : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v9)),
        };
        0x2::event::emit<PopkinsTransferred>(v10);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v9);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v8, arg5);
    }

    public fun attributes(arg0: &Popkins) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun avatar_thumb_url(arg0: &Popkins) : 0x1::string::String {
        arg0.avatar_thumb_url
    }

    public fun avatar_url(arg0: &Popkins) : 0x1::string::String {
        arg0.avatar_url
    }

    public fun burn(arg0: &mut PopkinsRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        validate_popkins_registry_policy_version(arg0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<Popkins>(arg1, 0x2::kiosk::list_with_purchase_cap<Popkins>(arg1, arg2, arg3, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Popkins>(&arg0.empty_policy, v1);
        let Popkins {
            id               : v5,
            name             : _,
            link             : _,
            image_url        : _,
            avatar_url       : _,
            avatar_thumb_url : _,
            description      : _,
            project_url      : _,
            creator          : _,
            key              : v14,
            attributes       : _,
        } = v0;
        let v16 = v5;
        let v17 = PopkinsBurned{
            popkins_id : 0x2::object::uid_to_inner(&v16),
            key        : v14,
        };
        0x2::event::emit<PopkinsBurned>(v17);
        0x2::object::delete(v16);
    }

    public fun creator(arg0: &Popkins) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Popkins) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &Popkins) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &Popkins) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: POPKINS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POPKINS_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Popkins>(&v0, arg1);
        let v3 = PopkinsRegistryPolicy{
            id           : 0x2::object::new(arg1),
            version      : 2,
            empty_policy : v1,
            policy_cap   : v2,
        };
        0x2::transfer::share_object<PopkinsRegistryPolicy>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun key(arg0: &Popkins) : 0x1::string::String {
        arg0.key
    }

    public fun link(arg0: &Popkins) : 0x1::string::String {
        arg0.link
    }

    public fun mint(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::WhiteListMintRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) : Popkins {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_whitelist_version(arg0);
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg11)), 0);
        let v0 = 0x2::object::new(arg11);
        let v1 = PopkinsMinted{
            popkins_id : 0x2::object::uid_to_inner(&v0),
            key        : arg9,
        };
        0x2::event::emit<PopkinsMinted>(v1);
        Popkins{
            id               : v0,
            name             : arg1,
            link             : arg2,
            image_url        : arg3,
            avatar_url       : arg4,
            avatar_thumb_url : arg5,
            description      : arg6,
            project_url      : arg7,
            creator          : arg8,
            key              : arg9,
            attributes       : arg10,
        }
    }

    public fun name(arg0: &Popkins) : 0x1::string::String {
        arg0.name
    }

    public fun project_url(arg0: &Popkins) : 0x1::string::String {
        arg0.project_url
    }

    public fun pump_popkins_registry_policy_version(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &mut PopkinsRegistryPolicy) {
        arg1.version = 2;
    }

    public fun validate_popkins_registry_policy_version(arg0: &PopkinsRegistryPolicy) {
        assert!(arg0.version == 2, 1);
    }

    // decompiled from Move bytecode v6
}

