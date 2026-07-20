module 0x3619f78648e7e1c5323db758ae2e40c5bb24a07ffa72ec000d3960f7badb7f60::great_wave {
    struct GREAT_WAVE has drop {
        dummy_field: bool,
    }

    struct GreatWave has store, key {
        id: 0x2::object::UID,
        edition: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted: u64,
        max_supply: u64,
        price: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Minted has copy, drop {
        edition: u64,
        buyer: address,
    }

    public fun edition(arg0: &GreatWave) : u64 {
        arg0.edition
    }

    fun edition_name(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"The Great Wave #");
        0x1::string::append(&mut v0, u64_to_string(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" / 36"));
        v0
    }

    fun init(arg0: GREAT_WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GREAT_WAVE>(arg0, arg1);
        let v1 = 0x2::display::new<GreatWave>(&v0, arg1);
        0x2::display::add<GreatWave>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<GreatWave>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<GreatWave>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<GreatWave>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Katsushika Hokusai (c.1831) - public domain"));
        0x2::display::update_version<GreatWave>(&mut v1);
        let v2 = Collection{
            id         : 0x2::object::new(arg1),
            minted     : 0,
            max_supply : 36,
            price      : 10000000000,
            funds      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Collection>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GreatWave>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &mut Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : GreatWave {
        assert!(arg0.minted < arg0.max_supply, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.price, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = Minted{
            edition : v0,
            buyer   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Minted>(v1);
        GreatWave{
            id          : 0x2::object::new(arg2),
            edition     : v0,
            name        : edition_name(v0),
            image_url   : 0x1::string::utf8(b"https://morphogen-crypto.github.io/art/great-wave.jpg"),
            description : 0x1::string::utf8(b"The Great Wave off Kanagawa by Katsushika Hokusai (c.1831). Public-domain artwork, minted as a numbered collectible edition on Sui by Morphogen. Collectible art - not an investment, no promise of returns."),
        }
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun price(arg0: &Collection) : u64 {
        arg0.price
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.funds, 0x2::balance::value<0x2::sui::SUI>(&arg1.funds)), arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

