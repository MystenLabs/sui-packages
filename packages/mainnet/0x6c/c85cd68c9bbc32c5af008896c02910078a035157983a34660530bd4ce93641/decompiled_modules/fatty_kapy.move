module 0x6cc85cd68c9bbc32c5af008896c02910078a035157983a34660530bd4ce93641::fatty_kapy {
    struct FATTY_KAPY has drop {
        dummy_field: bool,
    }

    struct Kapy has store, key {
        id: 0x2::object::UID,
        index: u16,
        username: 0x1::string::String,
        belongings: 0x2::vec_set::VecSet<u8>,
        level: u8,
        bytes: vector<u8>,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        supply: u16,
    }

    struct KapyWrappedInfo has store {
        age: u8,
        gender: bool,
        height: u64,
    }

    struct Hat has store, key {
        id: 0x2::object::UID,
        color: 0x1::string::String,
        size: u8,
    }

    public fun add_info(arg0: &mut Kapy, arg1: u8, arg2: bool, arg3: u64) {
        let v0 = KapyWrappedInfo{
            age    : arg1,
            gender : arg2,
            height : arg3,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, KapyWrappedInfo>(&mut arg0.id, 0x1::type_name::get<KapyWrappedInfo>(), v0);
    }

    public fun belongings(arg0: &Kapy) : &0x2::vec_set::VecSet<u8> {
        &arg0.belongings
    }

    public fun carry(arg0: &mut Kapy, arg1: 0x6cc85cd68c9bbc32c5af008896c02910078a035157983a34660530bd4ce93641::orange::Orange) {
        let v0 = 0x6cc85cd68c9bbc32c5af008896c02910078a035157983a34660530bd4ce93641::orange::destroy(arg1);
        if (0x2::vec_set::contains<u8>(belongings(arg0), &v0)) {
            err_carry_same_kind_of_orange();
        };
        0x2::vec_set::insert<u8>(&mut arg0.belongings, v0);
        arg0.level = (0x2::vec_set::size<u8>(belongings(arg0)) as u8);
    }

    public fun equip_hat(arg0: &mut Kapy, arg1: 0x1::string::String, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Hat{
            id    : 0x2::object::new(arg3),
            color : arg1,
            size  : arg2,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, Hat>(&mut arg0.id, 0x1::type_name::get<Hat>(), v0);
    }

    fun err_carry_same_kind_of_orange() {
        abort 0
    }

    public fun index(arg0: &Kapy) : u16 {
        arg0.index
    }

    fun init(arg0: FATTY_KAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Mover: {username}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Each orange represents your effort and achievement!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/Qmd9RpFKPBDzHdfnq7HSdhND9svg1fJxr7GAwTYwfEr5vh/{index}_{level}o.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://lu.ma/skany77u"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket X Typus X Scallop"));
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::package::claim<FATTY_KAPY>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Kapy>(&v5, v0, v2, arg1);
        0x2::display::update_version<Kapy>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Kapy>>(v6, v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v4);
        let v7 = MintCap{
            id     : 0x2::object::new(arg1),
            supply : 0,
        };
        0x2::transfer::transfer<MintCap>(v7, v4);
    }

    public fun level(arg0: &Kapy) : u8 {
        arg0.level
    }

    public fun mint(arg0: &mut MintCap, arg1: &mut 0x2::tx_context::TxContext) : Kapy {
        arg0.supply = supply(arg0) + 1;
        Kapy{
            id         : 0x2::object::new(arg1),
            index      : supply(arg0),
            username   : 0x1::string::utf8(b""),
            belongings : 0x2::vec_set::empty<u8>(),
            level      : 0,
            bytes      : b"",
        }
    }

    entry fun mint_to(arg0: &mut MintCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Kapy>(mint(arg0, arg2), arg1);
    }

    public fun supply(arg0: &MintCap) : u16 {
        arg0.supply
    }

    public fun update_username(arg0: &mut Kapy, arg1: 0x1::string::String) {
        arg0.username = arg1;
    }

    public fun username(arg0: &Kapy) : 0x1::string::String {
        arg0.username
    }

    // decompiled from Move bytecode v6
}

