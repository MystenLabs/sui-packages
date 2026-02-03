module 0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config {
    struct Config has store, key {
        id: 0x2::object::UID,
        alpha: u8,
        rake_bps: u16,
        price_per_pot: u64,
        max_pots_per_player: u8,
        num_pots: u8,
        min_players: u8,
    }

    public fun get_alpha(arg0: &Config) : u8 {
        arg0.alpha
    }

    public fun get_max_pots_per_player(arg0: &Config) : u8 {
        arg0.max_pots_per_player
    }

    public fun get_min_players(arg0: &Config) : u8 {
        arg0.min_players
    }

    public fun get_num_pots(arg0: &Config) : u8 {
        arg0.num_pots
    }

    public fun get_price_per_pot(arg0: &Config) : u64 {
        arg0.price_per_pot
    }

    public fun get_rake_bps(arg0: &Config) : u16 {
        arg0.rake_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            alpha               : 1,
            rake_bps            : 1000,
            price_per_pot       : 2000000000,
            max_pots_per_player : 3,
            num_pots            : 8,
            min_players         : 2,
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    public fun set_alpha(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Config, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.alpha = arg2;
    }

    public fun set_max_pots_per_player(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Config, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.max_pots_per_player = arg2;
    }

    public fun set_num_pots(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Config, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.num_pots = arg2;
    }

    public fun set_price_per_pot(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.price_per_pot = arg2;
    }

    public fun set_rake_bps(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Config, arg2: u16, arg3: &0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.rake_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

