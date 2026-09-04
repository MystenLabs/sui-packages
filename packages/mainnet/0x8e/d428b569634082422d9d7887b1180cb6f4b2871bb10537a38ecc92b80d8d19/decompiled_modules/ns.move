module 0x8ed428b569634082422d9d7887b1180cb6f4b2871bb10537a38ecc92b80d8d19::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SignedNS has store, key {
        id: 0x2::object::UID,
        art_id: u64,
        copy_num: u64,
        total: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct Bought has copy, drop {
        art_id: u64,
        amount: u64,
        payer: address,
    }

    public fun buy(arg0: &mut Vault, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui, arg2);
        let v1 = Bought{
            art_id : arg1,
            amount : v0,
            payer  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Bought>(v1);
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NS>(arg0, arg1);
        let v1 = 0x2::display::new<SignedNS>(&v0, arg1);
        0x2::display::add<SignedNS>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SignedNS>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SignedNS>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<SignedNS>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://jackbeatnic.github.io"));
        0x2::display::add<SignedNS>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Jack Beatnic"));
        0x2::display::update_version<SignedNS>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SignedNS>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = Vault{
            id  : 0x2::object::new(arg1),
            sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v3);
    }

    public fun mint(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = SignedNS{
            id          : 0x2::object::new(arg8),
            art_id      : arg1,
            copy_num    : arg2,
            total       : arg3,
            name        : arg4,
            description : arg5,
            url         : arg6,
        };
        0x2::transfer::public_transfer<SignedNS>(v0, arg7);
    }

    public fun withdraw(arg0: &mut Vault, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui)), arg2)
    }

    // decompiled from Move bytecode v7
}

