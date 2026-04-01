module 0x28fed2b07fe070c7794d3e7fcbac4ec9e7f933f426f1abb8e2eff1eaad558017::suishells {
    struct SUISHELLS has drop {
        dummy_field: bool,
    }

    struct TerminalShell has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        theme_id: u64,
        os_type: u64,
        prompt_style: u64,
        prompt_icon: u64,
        custom_text: 0x1::string::String,
        reroll_count: u64,
        epoch_reroll_count: u64,
        last_reroll_epoch: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        theme_names: vector<0x1::string::String>,
        num_os_types: u64,
        num_prompt_styles: u64,
        num_prompt_icons: u64,
    }

    struct MintTracker has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<address, bool>,
        total_minted: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ShellMinted has copy, drop {
        shell_id: 0x2::object::ID,
        owner: address,
        theme_id: u64,
    }

    struct ShellRerolled has copy, drop {
        shell_id: 0x2::object::ID,
        reroll_count: u64,
        cost: u64,
    }

    entry fun add_theme(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg1.theme_names, arg2);
    }

    public fun config_theme_name(arg0: &Config, arg1: u64) : 0x1::string::String {
        *0x1::vector::borrow<0x1::string::String>(&arg0.theme_names, arg1)
    }

    fun init(arg0: SUISHELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUISHELLS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"4120537569205368656c6c20e28094207b6e616d657d207465726d696e616c207468656d652e205265726f6c6c6564207b7265726f6c6c5f636f756e747d2074696d65732e"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suishells.com/api/shell-image?theme_id={theme_id}&os_type={os_type}&prompt_style={prompt_style}&prompt_icon={prompt_icon}&custom_text={custom_text}&reroll_count={reroll_count}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suishells.com"));
        let v5 = 0x2::display::new_with_fields<TerminalShell>(&v0, v1, v3, arg1);
        0x2::display::update_version<TerminalShell>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TerminalShell>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Dracula"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Solarized Dark"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Solarized Light"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Monokai"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Nord"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"One Dark"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Catppuccin Mocha"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Gruvbox"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Tokyo Night"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Rose Pine"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Kanagawa"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Everforest"));
        let v9 = Config{
            id                : 0x2::object::new(arg1),
            theme_names       : v7,
            num_os_types      : 5,
            num_prompt_styles : 6,
            num_prompt_icons  : 7,
        };
        0x2::transfer::share_object<Config>(v9);
        let v10 = MintTracker{
            id           : 0x2::object::new(arg1),
            minted       : 0x2::table::new<address, bool>(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<MintTracker>(v10);
        let v11 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v11);
    }

    entry fun mint(arg0: &Config, arg1: &mut MintTracker, arg2: &0x2::random::Random, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, bool>(&arg1.minted, v0), 0);
        assert!(0x1::string::length(&arg3) <= 64, 2);
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let v2 = 0x2::random::generate_u64(&mut v1) % 0x1::vector::length<0x1::string::String>(&arg0.theme_names);
        let v3 = TerminalShell{
            id                 : 0x2::object::new(arg4),
            name               : *0x1::vector::borrow<0x1::string::String>(&arg0.theme_names, v2),
            theme_id           : v2,
            os_type            : 0x2::random::generate_u64(&mut v1) % arg0.num_os_types,
            prompt_style       : 0x2::random::generate_u64(&mut v1) % arg0.num_prompt_styles,
            prompt_icon        : 0x2::random::generate_u64(&mut v1) % arg0.num_prompt_icons,
            custom_text        : arg3,
            reroll_count       : 0,
            epoch_reroll_count : 0,
            last_reroll_epoch  : 0x2::tx_context::epoch(arg4),
        };
        let v4 = ShellMinted{
            shell_id : 0x2::object::id<TerminalShell>(&v3),
            owner    : v0,
            theme_id : v2,
        };
        0x2::event::emit<ShellMinted>(v4);
        0x2::table::add<address, bool>(&mut arg1.minted, v0, true);
        arg1.total_minted = arg1.total_minted + 1;
        0x2::transfer::transfer<TerminalShell>(v3, v0);
    }

    public fun num_themes(arg0: &Config) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.theme_names)
    }

    entry fun reroll(arg0: &mut TerminalShell, arg1: &Config, arg2: &mut Treasury, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        if (v0 != arg0.last_reroll_epoch) {
            arg0.epoch_reroll_count = 0;
            arg0.last_reroll_epoch = v0;
        };
        let v1 = 1000000000 << (arg0.epoch_reroll_count as u8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v1, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v2 = 0x2::random::new_generator(arg4, arg5);
        arg0.theme_id = 0x2::random::generate_u64(&mut v2) % 0x1::vector::length<0x1::string::String>(&arg1.theme_names);
        arg0.os_type = 0x2::random::generate_u64(&mut v2) % arg1.num_os_types;
        arg0.prompt_style = 0x2::random::generate_u64(&mut v2) % arg1.num_prompt_styles;
        arg0.prompt_icon = 0x2::random::generate_u64(&mut v2) % arg1.num_prompt_icons;
        arg0.name = *0x1::vector::borrow<0x1::string::String>(&arg1.theme_names, arg0.theme_id);
        arg0.epoch_reroll_count = arg0.epoch_reroll_count + 1;
        arg0.reroll_count = arg0.reroll_count + 1;
        let v3 = ShellRerolled{
            shell_id     : 0x2::object::id<TerminalShell>(arg0),
            reroll_count : arg0.reroll_count,
            cost         : v1,
        };
        0x2::event::emit<ShellRerolled>(v3);
    }

    public fun reroll_cost(arg0: u64) : u64 {
        1000000000 << (arg0 as u8)
    }

    entry fun set_num_os_types(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.num_os_types = arg2;
    }

    entry fun set_num_prompt_icons(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.num_prompt_icons = arg2;
    }

    entry fun set_num_prompt_styles(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.num_prompt_styles = arg2;
    }

    public fun shell_custom_text(arg0: &TerminalShell) : 0x1::string::String {
        arg0.custom_text
    }

    public fun shell_epoch_reroll_count(arg0: &TerminalShell) : u64 {
        arg0.epoch_reroll_count
    }

    public fun shell_name(arg0: &TerminalShell) : 0x1::string::String {
        arg0.name
    }

    public fun shell_reroll_count(arg0: &TerminalShell) : u64 {
        arg0.reroll_count
    }

    public fun shell_theme_id(arg0: &TerminalShell) : u64 {
        arg0.theme_id
    }

    public fun total_minted(arg0: &MintTracker) : u64 {
        arg0.total_minted
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    entry fun update_text(arg0: &mut TerminalShell, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 64, 2);
        arg0.custom_text = arg1;
    }

    entry fun update_theme_name(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: 0x1::string::String) {
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&arg1.theme_names), 3);
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg1.theme_names, arg2) = arg3;
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

