module 0xb91c50cd48360722f39f791d9469659c4f6bbd72227629efa4e4d35a45a4fe5d::azimals {
    struct AZIMALS has drop {
        dummy_field: bool,
    }

    struct Azimal has store, key {
        id: 0x2::object::UID,
        ancestor: 0x1::string::String,
        breed: 0x1::string::String,
        class: 0x1::string::String,
        clan: 0x1::string::String,
        origin: 0x1::string::String,
        variant: 0x1::string::String,
        rarity: 0x1::string::String,
        special: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        current_price: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun generate_random_attributes(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x2::url::Url) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = vector[b"Xolodog", b"Jaguar", b"Turtle", b"Axolotl", b"Croc", b"Quatzl", b"Falcon", b"Iguana", b"Eagle", b"Ape"];
        let v2 = vector[b"Xolomar", b"Itsomay", b"Zozumi", b"Axocan", b"Miqoza", b"Quatsu", b"Zerazuma", b"Genzo", b"Eagumar", b"Itzchoko"];
        let v3 = vector[b"Land", b"Land", b"Water", b"Water", b"Water", b"Air", b"Air", b"Land", b"Air", b"Land"];
        let v4 = vector[b"Xolomaru", b"Itzomaya", b"Ixzozumi", b"Ayozumi", b"Mixcozan", b"Quetzawara", b"Zumaquetza", b"Hueyzenko", b"Cuauhmaru", b"Simiano"];
        let v5 = vector[b"Heloderm", b"Pantera", b"Tapiru", b"Pelecano", b"Dorsali", b"Mocinno", b"Yucateco", b"Mapache", b"Zopilote", b"Ateles"];
        let v6 = vector[vector[b"Natural", b"Bloodhound", b"Wardog"], vector[b"Natural", b"Hunter", b"King"], vector[b"Natural", b"Roja", b"Turatan"], vector[b"Natural", b"Glowing", b"Electric"], vector[b"Natural", b"Raider", b"Regal"], vector[b"Natural", b"Flappy", b"Laserbeak"], vector[b"Natural", b"Devilish", b"Angelic"], vector[b"Natural", b"Gila", b"Kamo"], vector[b"Natural", b"Dawn", b"Harpy"], vector[b"Natural", b"Flexing", b"Kong"]];
        let v7 = vector[b"Vicious", b"Strength", b"Armor", b"Agile", b"Vicious", b"Agile", b"Stamina", b"Agile", b"Stamina", b"Strength"];
        let v8 = 0x2::random::generate_u64_in_range(&mut v0, 0, 9);
        let v9 = 0x2::random::generate_u64_in_range(&mut v0, 0, 99);
        let (v10, v11) = if (v9 < 70) {
            (0, 0x1::string::utf8(b"Regular"))
        } else if (v9 < 70 + 25) {
            (1, 0x1::string::utf8(b"Rare"))
        } else {
            (2, 0x1::string::utf8(b"Legendary"))
        };
        let v12 = b"https://raw.githubusercontent.com/azteqmetaverse/AZTEQ/main/Azimals/";
        let v13 = 0x1::ascii::into_bytes(0x1::ascii::string(*0x1::vector::borrow<vector<u8>>(&v2, v8)));
        let v14 = 0;
        while (v14 < 0x1::vector::length<u8>(&v13)) {
            let v15 = *0x1::vector::borrow<u8>(&v13, v14);
            if (v15 >= 65 && v15 <= 90) {
                *0x1::vector::borrow_mut<u8>(&mut v13, v14) = v15 + 32;
            };
            v14 = v14 + 1;
        };
        0x1::vector::append<u8>(&mut v12, v13);
        0x1::vector::push_back<u8>(&mut v12, 45);
        0x1::vector::push_back<u8>(&mut v12, ((v10 + 1) as u8) + 48);
        0x1::vector::append<u8>(&mut v12, b".png");
        (0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v2, v8)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v1, v8)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v3, v8)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v4, v8)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v5, v8)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(0x1::vector::borrow<vector<vector<u8>>>(&v6, v8), v10)), v11, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v7, v8)), 0x2::url::new_unsafe_from_bytes(v12))
    }

    public fun get_current_price(arg0: &Collection) : u64 {
        arg0.current_price
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted_count
    }

    fun init(arg0: AZIMALS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Collection{
            id            : 0x2::object::new(arg1),
            minted_count  : 0,
            current_price : 10000000000,
            treasury      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Collection>(v1);
        let v2 = 0x2::package::claim<AZIMALS>(arg0, arg1);
        let v3 = 0x2::display::new<Azimal>(&v2, arg1);
        0x2::display::add<Azimal>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Azimal {breed} #{minted_count}"));
        0x2::display::add<Azimal>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An Azimal NFT with {rarity} rarity, {special} special trait, and {class} class."));
        0x2::display::add<Azimal>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Azimal>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"AZTEQ Metaverse"));
        0x2::display::add<Azimal>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://azimals.azteq.online"));
        0x2::display::update_version<Azimal>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<Azimal>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.current_price, 1);
        assert!(arg0.minted_count < 50000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = generate_random_attributes(arg2, arg3);
        let v9 = Azimal{
            id        : 0x2::object::new(arg3),
            ancestor  : v0,
            breed     : v1,
            class     : v2,
            clan      : v3,
            origin    : v4,
            variant   : v5,
            rarity    : v6,
            special   : v7,
            image_url : v8,
        };
        0x2::transfer::public_transfer<Azimal>(v9, 0x2::tx_context::sender(arg3));
        arg0.minted_count = arg0.minted_count + 1;
        if (arg0.current_price < 25000000000) {
            arg0.current_price = arg0.current_price + 100000000;
        };
    }

    public entry fun withdraw_treasury(arg0: &mut Collection, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

