module 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::launchpad {
    struct LaunchpadStorage has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        website: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        projects: 0x2::vec_set::VecSet<0x1::string::String>,
        other: 0x2::object_bag::ObjectBag,
    }

    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    fun display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{website}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"YouSUI Creator"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public entry fun claim_refund_preregister<T0>(arg0: &0x2::clock::Clock, arg1: &mut LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::claim_refund_preregister<T0>(arg0, 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::Round>(borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project>(arg1, arg2), arg3), arg4);
    }

    public entry fun claim_vesting<T0>(arg0: &0x2::clock::Clock, arg1: &mut LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::claim_vesting<T0>(arg0, 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::Round>(borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project>(arg1, arg2), arg3), arg4, arg5);
    }

    public entry fun purchase_nor<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x2::coin::Coin<T1>>, arg6: &mut 0x2::tx_context::TxContext) {
        0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::purchase_nor<T0, T1>(arg0, 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::Round>(borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project>(arg1, arg2), arg3), arg4, arg5, arg6);
    }

    public entry fun purchase_ref<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x2::coin::Coin<T1>>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::purchase_ref<T0, T1>(arg0, 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::Round>(borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project>(arg1, arg2), arg3), arg4, arg5, arg6, arg7);
    }

    public entry fun purchase_yousui_og_holder<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut LaunchpadStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x2::coin::Coin<T1>>, arg6: &0x6a29b3b80de2bd69ee94b2a2f11e5bf2e3614d1cc08f1cb16eefa290bc859cb0::nft::YOUSUINFT, arg7: &mut 0x2::tx_context::TxContext) {
        0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::purchase_yousui_og_holder<T0, T1>(arg0, 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::ido::Round>(borrow_mut_dynamic_object_field<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project>(arg1, arg2), arg3), arg4, arg5, arg6, arg7);
    }

    fun add_dof<T0: store + key>(arg0: &mut LaunchpadStorage, arg1: 0x1::string::String, arg2: T0) {
        0x2::dynamic_object_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun add_project(arg0: &mut LaunchpadStorage, arg1: 0x1::string::String, arg2: 0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project) {
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.projects, arg1);
        add_dof<0x9ec7fc7165fe5558574ae87120f8a469686dc56877fa2e4ad4ee6b8c3907a965::project::Project>(arg0, arg1, arg2);
    }

    public(friend) fun borrow_mut_dynamic_object_field<T0: store + key>(arg0: &mut LaunchpadStorage, arg1: 0x1::string::String) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, T0>(&mut arg0.id, arg1)
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LAUNCHPAD>(arg0, arg1);
        display<LaunchpadStorage>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v1 = LaunchpadStorage{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"YouSUI Launchpad"),
            image       : 0x1::string::utf8(b"https://kol-sale.yousui.io/images/background/water-seek.jpg"),
            website     : 0x1::string::utf8(b"https://yousui.io"),
            link        : 0x1::string::utf8(b"https://kol-sale.yousui.io"),
            description : 0x1::string::utf8(b"YouSUI is an All-In-One platform that runs on the Sui Blockchain and includes DEX, Launchpad, NFT Marketplace and Bridge."),
            projects    : 0x2::vec_set::empty<0x1::string::String>(),
            other       : 0x2::object_bag::new(arg1),
        };
        0x2::transfer::share_object<LaunchpadStorage>(v1);
    }

    // decompiled from Move bytecode v6
}

