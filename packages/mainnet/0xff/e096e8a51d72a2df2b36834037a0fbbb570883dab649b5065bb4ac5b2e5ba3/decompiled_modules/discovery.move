module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery {
    struct Discovery has store, key {
        id: 0x2::object::UID,
        kind: u8,
        season: u64,
        serial: u64,
        origin: u8,
        name: 0x1::string::String,
        finder: address,
    }

    struct BookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BookKey6 has copy, drop, store {
        dummy_field: bool,
    }

    struct Book has store {
        open: bool,
        finish_line: u64,
        common_name: 0x1::string::String,
        special_name: 0x1::string::String,
        chest_scrap: u64,
        chest_fragments: u64,
        fragments_for_common: u64,
        chance_bps: u64,
        special_cap: u64,
        fallback_scrap: u64,
        commons: 0x2::table::Table<u64, u64>,
        specials: 0x2::table::Table<u64, u64>,
        fragments: 0x2::table::Table<address, u64>,
    }

    struct TradeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DiscoveryPolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScrapPolicyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Found has copy, drop {
        discovery: 0x2::object::ID,
        kind: u8,
        season: u64,
        serial: u64,
        origin: u8,
        finder: address,
    }

    public(friend) fun add_book(arg0: &mut 0x2::object::UID, arg1: Book) {
        let v0 = BookKey6{dummy_field: false};
        0x2::dynamic_field::add<BookKey6, Book>(arg0, v0, arg1);
    }

    public(friend) fun add_fragments(arg0: &mut Book, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(&arg0.fragments, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.fragments, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.fragments, arg1);
        *v0 = *v0 + arg2;
    }

    public(friend) fun book(arg0: &0x2::object::UID) : &Book {
        let v0 = BookKey6{dummy_field: false};
        0x2::dynamic_field::borrow<BookKey6, Book>(arg0, v0)
    }

    public(friend) fun book_mut(arg0: &mut 0x2::object::UID) : &mut Book {
        let v0 = BookKey6{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BookKey6, Book>(arg0, v0)
    }

    public(friend) fun by_finishing() : u8 {
        0
    }

    public(friend) fun chest_gift(arg0: &Book) : (u64, u64) {
        (arg0.chest_scrap, arg0.chest_fragments)
    }

    entry fun create_display(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::cap_shed(arg0) == 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed>(arg1), 522);
        let v0 = 0x2::object::id<0x2::display_registry::DisplayRegistry>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0xd, 521);
        let (v1, v2) = 0x2::display_registry::new<Discovery>(arg2, 0x1::internal::permit<Discovery>(), arg3);
        let v3 = v2;
        let v4 = v1;
        let v5 = fields();
        let v6 = keys();
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::string::String>(&v6)) {
            0x2::display_registry::set<Discovery>(&mut v4, &v3, *0x1::vector::borrow<0x1::string::String>(&v6, v7), *0x1::vector::borrow<0x1::string::String>(&v5, v7));
            v7 = v7 + 1;
        };
        0x2::display_registry::share<Discovery>(v4);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Discovery>>(v3, 0x2::tx_context::sender(arg3));
    }

    fun fields() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{name} #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Brought up from under the MORTEM graves in season {season}."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://mortem.alienz.tech/assets/finds/v1/s{season}-{kind}.webp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://mortem.alienz.tech/assets/finds/v1/s{season}-{kind}.webp"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://mortem.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"PulseSinister & Sudcero"));
        v0
    }

    public fun finder(arg0: &Discovery) : address {
        arg0.finder
    }

    public(friend) fun finish_line(arg0: &Book) : u64 {
        arg0.finish_line
    }

    public(friend) fun fragments_for_common(arg0: &Book) : u64 {
        arg0.fragments_for_common
    }

    public(friend) fun fragments_of(arg0: &Book, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.fragments, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.fragments, arg1)
        } else {
            0
        }
    }

    public(friend) fun has_book(arg0: &0x2::object::UID) : bool {
        let v0 = BookKey6{dummy_field: false};
        if (0x2::dynamic_field::exists<BookKey6>(arg0, v0)) {
            true
        } else {
            let v2 = BookKey{dummy_field: false};
            0x2::dynamic_field::exists<BookKey>(arg0, v2)
        }
    }

    public(friend) fun has_book_here(arg0: &0x2::object::UID) : bool {
        let v0 = BookKey6{dummy_field: false};
        0x2::dynamic_field::exists<BookKey6>(arg0, v0)
    }

    public(friend) fun is_open(arg0: &Book) : bool {
        arg0.open
    }

    fun keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        v0
    }

    public fun kind(arg0: &Discovery) : u8 {
        arg0.kind
    }

    fun mint(arg0: u8, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Discovery {
        let v0 = Discovery{
            id     : 0x2::object::new(arg6),
            kind   : arg0,
            season : arg1,
            serial : arg2,
            origin : arg3,
            name   : arg4,
            finder : arg5,
        };
        let v1 = Found{
            discovery : 0x2::object::id<Discovery>(&v0),
            kind      : arg0,
            season    : arg1,
            serial    : arg2,
            origin    : arg3,
            finder    : arg5,
        };
        0x2::event::emit<Found>(v1);
        v0
    }

    public(friend) fun mint_common(arg0: &mut Book, arg1: u64, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Discovery {
        let v0 = &mut arg0.commons;
        mint(0, arg1, next(v0, arg1), arg2, arg0.common_name, arg3, arg4)
    }

    public(friend) fun mint_special(arg0: &mut Book, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Discovery {
        let v0 = &mut arg0.specials;
        mint(1, arg1, next(v0, arg1), 2, arg0.special_name, arg2, arg3)
    }

    public(friend) fun move_book(arg0: &mut 0x2::object::UID) {
        let v0 = BookKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BookKey>(arg0, v0)) {
            let v1 = BookKey{dummy_field: false};
            let v2 = BookKey6{dummy_field: false};
            0x2::dynamic_field::add<BookKey6, Book>(arg0, v2, 0x2::dynamic_field::remove<BookKey, Book>(arg0, v1));
        };
    }

    public fun name(arg0: &Discovery) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new_book(arg0: &mut 0x2::tx_context::TxContext) : Book {
        Book{
            open                 : false,
            finish_line          : 66600,
            common_name          : 0x1::string::utf8(b"Find of the Deep"),
            special_name         : 0x1::string::utf8(b"Rare Find of the Deep"),
            chest_scrap          : 3,
            chest_fragments      : 1,
            fragments_for_common : 6,
            chance_bps           : 300,
            special_cap          : 33,
            fallback_scrap       : 5,
            commons              : 0x2::table::new<u64, u64>(arg0),
            specials             : 0x2::table::new<u64, u64>(arg0),
            fragments            : 0x2::table::new<address, u64>(arg0),
        }
    }

    fun next(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, u64>(arg0, arg1)) {
            0x2::table::add<u64, u64>(arg0, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<u64, u64>(arg0, arg1);
        *v0 = *v0 + 1;
        *v0
    }

    public(friend) fun odds(arg0: &Book) : (u64, u64, u64) {
        (arg0.chance_bps, arg0.special_cap, arg0.fallback_scrap)
    }

    public fun origin(arg0: &Discovery) : u8 {
        arg0.origin
    }

    fun scrap_fields() : vector<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"https://mortem.alienz.tech/assets/shovels/v1/scrap.webp");
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(x"536372617020c397207b756e6974737d"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"What the dig leaves under the MORTEM graves. The forge mends shovels with it."));
        0x1::vector::push_back<0x1::string::String>(v2, v0);
        0x1::vector::push_back<0x1::string::String>(v2, v0);
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"https://mortem.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"PulseSinister & Sudcero"));
        v1
    }

    public fun season(arg0: &Discovery) : u64 {
        arg0.season
    }

    public fun serial(arg0: &Discovery) : u64 {
        arg0.serial
    }

    public(friend) fun set_names(arg0: &mut Book, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        arg0.common_name = arg1;
        arg0.special_name = arg2;
    }

    public(friend) fun set_open(arg0: &mut Book, arg1: bool) {
        arg0.open = arg1;
    }

    public(friend) fun set_rules(arg0: &mut Book, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg0.finish_line = arg1;
        arg0.chest_scrap = arg2;
        arg0.chest_fragments = arg3;
        arg0.fragments_for_common = arg4;
        arg0.chance_bps = arg5;
        arg0.special_cap = arg6;
        arg0.fallback_scrap = arg7;
    }

    entry fun setup_trade(arg0: &0x2::package::Publisher, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::Shed, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Discovery>(arg0), 520);
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::shed_uid_mut(arg1);
        let v1 = TradeKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<TradeKey>(v0, v1), 523);
        let v2 = TradeKey{dummy_field: false};
        0x2::dynamic_field::add<TradeKey, bool>(v0, v2, true);
        let (v3, v4) = 0x2::transfer_policy::new<Discovery>(arg0, arg3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Discovery>>(v3);
        let v5 = DiscoveryPolicyKey{dummy_field: false};
        0x2::dynamic_object_field::add<DiscoveryPolicyKey, 0x2::transfer_policy::TransferPolicyCap<Discovery>>(v0, v5, v4);
        let (v6, v7) = 0x2::transfer_policy::new<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>(arg0, arg3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>>(v6);
        let v8 = ScrapPolicyKey{dummy_field: false};
        0x2::dynamic_object_field::add<ScrapPolicyKey, 0x2::transfer_policy::TransferPolicyCap<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>>(v0, v8, v7);
        let v9 = 0x2::display::new_with_fields<Discovery>(arg0, keys(), fields(), arg3);
        0x2::display::update_version<Discovery>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<Discovery>>(v9, arg2);
        let v10 = 0x2::display::new_with_fields<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>(arg0, keys(), scrap_fields(), arg3);
        0x2::display::update_version<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::scrap::Scrap>>(v10, arg2);
    }

    public(friend) fun specials_found(arg0: &Book, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.specials, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.specials, arg1)
        } else {
            0
        }
    }

    public(friend) fun take_fragments(arg0: &mut Book, arg1: address, arg2: u64) : bool {
        if (fragments_of(arg0, arg1) < arg2) {
            return false
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.fragments, arg1);
        *v0 = *v0 - arg2;
        true
    }

    // decompiled from Move bytecode v7
}

