module 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::collection {
    struct BlubFam has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::attributes::Attributes,
        balance: 0x2::balance::Balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>,
    }

    struct BlubFamData has store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::attributes::Attributes,
        balance: 0x2::balance::Balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct WITNESS_RULE has drop {
        dummy_field: bool,
    }

    public fun attributes(arg0: &BlubFam) : 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::attributes::Attributes {
        arg0.attributes
    }

    public fun burn(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<BlubFam>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB> {
        0x2::kiosk::list<BlubFam>(arg1, arg2, arg0, 0);
        let (v0, v1) = 0x2::kiosk::purchase<BlubFam>(arg1, arg0, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v2 = v1;
        let v3 = WITNESS_RULE{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<BlubFam, WITNESS_RULE>(v3, arg3, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<BlubFam>(arg3, v2);
        let BlubFam {
            id         : v7,
            name       : _,
            url        : _,
            attributes : _,
            balance    : v11,
        } = v0;
        0x2::object::delete(v7);
        0x2::coin::from_balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(v11, arg4)
    }

    public(friend) fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut vector<0x1::string::String>, arg3: &mut vector<0x1::string::String>, arg4: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>) : BlubFamData {
        BlubFamData{
            name       : arg0,
            url        : arg1,
            attributes : 0x821d53808234415c7e2c1a75485129a9b50170d279ab3a9942b9c7131066199a::attributes::from_vec(arg2, arg3),
            balance    : 0x2::coin::into_balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(arg4),
        }
    }

    public fun image_url(arg0: &BlubFam) : 0x1::string::String {
        arg0.url
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<BlubFam>(&v0, arg1);
        0x2::display::add<BlubFam>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"BlubFam #{name}"));
        0x2::display::add<BlubFam>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Meet BlubFam! Group of BlubFam working together to grow our beloved Blub as the ugliest and dirtiest fish in the waters of the Sui Ocean. Community initiative: portions of the revenue will be used to buy back and burn $blub as well as reward community members."));
        0x2::display::add<BlubFam>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<BlubFam>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{url}"));
        0x2::display::update_version<BlubFam>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<BlubFam>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BlubFam>>(v2);
        let (v4, v5) = 0x2::transfer_policy::new<BlubFam>(&v0, arg1);
        let v6 = v5;
        let v7 = v4;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<BlubFam, WITNESS_RULE>(&mut v7, &v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BlubFam>>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BlubFam>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BlubFam>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BlubFam>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: BlubFamData, arg1: &mut 0x2::tx_context::TxContext) : BlubFam {
        let BlubFamData {
            name       : v0,
            url        : v1,
            attributes : v2,
            balance    : v3,
        } = arg0;
        BlubFam{
            id         : 0x2::object::new(arg1),
            name       : v0,
            url        : v1,
            attributes : v2,
            balance    : v3,
        }
    }

    public fun name(arg0: &BlubFam) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun reset_state(arg0: BlubFamData) : 0x2::balance::Balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB> {
        let BlubFamData {
            name       : _,
            url        : _,
            attributes : _,
            balance    : v3,
        } = arg0;
        v3
    }

    // decompiled from Move bytecode v6
}

