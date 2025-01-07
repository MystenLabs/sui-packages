module 0x20724f3f027964396c4ff3c075ef52ffffe0767ea01f1737d9694ddec91ddcc0::capybara_lootbox {
    struct CAPYBARA_LOOTBOX has drop {
        dummy_field: bool,
    }

    struct LootBoxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LootboxArgTBS has drop {
        user: address,
        uid: u64,
    }

    struct NFTFruitT<T0> has store, key {
        id: 0x2::object::UID,
        fruit_type: T0,
    }

    struct Banana {
        dummy_field: bool,
    }

    struct DataStorage has key {
        id: 0x2::object::UID,
        total_lootbox: u64,
        total_lootbox_opened: u64,
        total_fruit: u64,
        total_kapybara: u64,
        ids: 0x2::table::Table<u64, bool>,
        pk: vector<u8>,
    }

    struct NFTFruit has store, key {
        id: 0x2::object::UID,
        fruit_type: 0x1::string::String,
    }

    struct NFTLootbox has store, key {
        id: 0x2::object::UID,
    }

    struct KapybaraNFT has store, key {
        id: 0x2::object::UID,
    }

    public fun exchange_fruits_to_kapybara(arg0: &mut DataStorage, arg1: NFTFruit, arg2: NFTFruit, arg3: NFTFruit, arg4: NFTFruit, arg5: NFTFruit, arg6: &mut 0x2::tx_context::TxContext) {
        let NFTFruit {
            id         : v0,
            fruit_type : v1,
        } = arg1;
        assert!(v1 == 0x1::string::utf8(b"Lemon"), 3);
        let NFTFruit {
            id         : v2,
            fruit_type : v3,
        } = arg2;
        assert!(v3 == 0x1::string::utf8(b"Strawberry"), 3);
        let NFTFruit {
            id         : v4,
            fruit_type : v5,
        } = arg3;
        assert!(v5 == 0x1::string::utf8(b"Banana"), 3);
        let NFTFruit {
            id         : v6,
            fruit_type : v7,
        } = arg4;
        assert!(v7 == 0x1::string::utf8(b"Watermelon"), 3);
        let NFTFruit {
            id         : v8,
            fruit_type : v9,
        } = arg5;
        assert!(v9 == 0x1::string::utf8(b"Mushroom"), 3);
        0x2::object::delete(v0);
        0x2::object::delete(v2);
        0x2::object::delete(v4);
        0x2::object::delete(v6);
        0x2::object::delete(v8);
        arg0.total_fruit = arg0.total_fruit - 5;
        arg0.total_kapybara = arg0.total_kapybara + 1;
        let v10 = KapybaraNFT{id: 0x2::object::new(arg6)};
        0x2::transfer::public_transfer<KapybaraNFT>(v10, 0x2::tx_context::sender(arg6));
    }

    fun get_random_fruit(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : NFTFruit {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 200);
        let v2 = b"";
        if (v1 <= 3) {
            v2 = b"mushroom";
        };
        if (v1 > 3 && v1 <= 20) {
            v2 = b"watermelon";
        };
        if (v1 > 20 && v1 <= 50) {
            v2 = b"banana";
        };
        if (v1 > 50 && v1 <= 100) {
            v2 = b"strawberry";
        };
        if (v1 > 100 && v1 <= 200) {
            v2 = b"lemon";
        };
        NFTFruit{
            id         : 0x2::object::new(arg1),
            fruit_type : 0x1::string::utf8(v2),
        }
    }

    fun init(arg0: CAPYBARA_LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CAPYBARA_LOOTBOX>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Capybara NFT {fruit_type} fruit"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://capybara_static.8gen.team/{fruit_type}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://capybara_static.8gen.team/{fruit_type}_preview.png"));
        let v5 = 0x2::display::new_with_fields<NFTFruit>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFTFruit>(&mut v5);
        let v6 = 0x2::address::from_bytes(0x2::address::to_bytes(@0x3a1a0722453ff6da8a9695ef9588bd0ef57e60df8eee12f45cb792a170f179e1));
        let v7 = DataStorage{
            id                   : 0x2::object::new(arg1),
            total_lootbox        : 0,
            total_lootbox_opened : 0,
            total_fruit          : 0,
            total_kapybara       : 0,
            ids                  : 0x2::table::new<u64, bool>(arg1),
            pk                   : x"035229dff81f3e3f5a1526b92908752395d96bf6b41cc253b2ad5bebe503149cf2",
        };
        let v8 = LootBoxAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DataStorage>(v7);
        0x2::transfer::public_transfer<LootBoxAdminCap>(v8, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<NFTFruit>>(v5, v6);
    }

    public fun mint_fruit_by_admin(arg0: &0x20724f3f027964396c4ff3c075ef52ffffe0767ea01f1737d9694ddec91ddcc0::capybara_game_card::AdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTFruit{
            id         : 0x2::object::new(arg2),
            fruit_type : arg1,
        };
        0x2::transfer::public_transfer<NFTFruit>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_lootbox(arg0: &mut DataStorage, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<u64, bool>(&arg0.ids, arg1), 103);
        let v1 = serialize_lootbox_args(v0, arg1);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg2, &arg0.pk, &v1, 1), 104);
        arg0.total_lootbox = arg0.total_lootbox + 1;
        0x2::table::add<u64, bool>(&mut arg0.ids, arg1, true);
        0x2::transfer::public_transfer<NFTLootbox>(new_lootbox(arg3), v0);
    }

    fun new_lootbox(arg0: &mut 0x2::tx_context::TxContext) : NFTLootbox {
        NFTLootbox{id: 0x2::object::new(arg0)}
    }

    public entry fun open_lootbox(arg0: &mut DataStorage, arg1: &0x2::random::Random, arg2: NFTLootbox, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let NFTLootbox { id: v1 } = arg2;
        0x2::object::delete(v1);
        arg0.total_lootbox_opened = arg0.total_lootbox_opened + 1;
        arg0.total_fruit = arg0.total_fruit + 1;
        0x2::transfer::public_transfer<NFTFruit>(get_random_fruit(arg1, arg3), v0);
    }

    public fun serialize_lootbox_args(arg0: address, arg1: u64) : vector<u8> {
        let v0 = LootboxArgTBS{
            user : arg0,
            uid  : arg1,
        };
        0x1::bcs::to_bytes<LootboxArgTBS>(&v0)
    }

    // decompiled from Move bytecode v6
}

