module 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player {
    struct PLAYER has drop {
        dummy_field: bool,
    }

    struct Player has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        nonce: u64,
        last_checkin_epoch: u64,
        last_mint_epoch: u64,
        last_word_creation_epoch: u64,
        last_purchase_all_alphabets_epoch: u64,
        consecutive_epochs: u64,
        point_getter: bool,
        point_balance: 0x2::balance::Balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Player {
        Player{
            id                                : 0x2::object::new(arg1),
            name                              : arg0,
            nonce                             : 0,
            last_checkin_epoch                : 0,
            last_mint_epoch                   : 0,
            last_word_creation_epoch          : 0,
            last_purchase_all_alphabets_epoch : 0,
            consecutive_epochs                : 0,
            point_getter                      : false,
            point_balance                     : 0x2::balance::zero<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(),
        }
    }

    public fun id(arg0: &Player) : 0x2::object::ID {
        0x2::object::id<Player>(arg0)
    }

    public(friend) fun transfer(arg0: Player, arg1: address) {
        0x2::transfer::transfer<Player>(arg0, arg1);
    }

    public fun consecutive_epochs(arg0: &Player) : u64 {
        arg0.consecutive_epochs
    }

    fun init(arg0: PLAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PLAYER>(arg0, arg1);
        let v1 = 0x2::display::new<Player>(&v0, arg1);
        let v2 = &mut v1;
        set_display(v2);
        0x2::transfer::public_transfer<0x2::display::Display<Player>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun last_checkin_epoch(arg0: &Player) : u64 {
        arg0.last_checkin_epoch
    }

    public fun last_mint_epoch(arg0: &Player) : u64 {
        arg0.last_mint_epoch
    }

    public fun last_purchase_all_alphabets_epoch(arg0: &Player) : u64 {
        arg0.last_purchase_all_alphabets_epoch
    }

    public fun last_word_creation_epoch(arg0: &Player) : u64 {
        arg0.last_word_creation_epoch
    }

    public fun name(arg0: &Player) : 0x1::string::String {
        arg0.name
    }

    public fun nonce(arg0: &Player) : u64 {
        arg0.nonce
    }

    public fun point_balance(arg0: &Player) : &0x2::balance::Balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT> {
        &arg0.point_balance
    }

    public(friend) fun point_balance_mut(arg0: &mut Player) : &mut 0x2::balance::Balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT> {
        &mut arg0.point_balance
    }

    public fun point_getter(arg0: &Player) : bool {
        arg0.point_getter
    }

    public(friend) fun point_getter_mut(arg0: &mut Player) : &mut bool {
        &mut arg0.point_getter
    }

    public(friend) fun set_consecutive_epochs(arg0: &mut Player, arg1: u64) {
        arg0.consecutive_epochs = arg1;
    }

    fun set_display(arg0: &mut 0x2::display::Display<Player>) {
        0x2::display::add<Player>(arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Alphabets Player"));
        0x2::display::add<Player>(arg0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 200 200'%3E%3Cdefs%3E%3ClinearGradient id='bgGradient' x1='0%25' y1='0%25' x2='100%25' y2='100%25'%3E%3Cstop offset='0%25' style='stop-color:%234B0082;stop-opacity:1' /%3E%3Cstop offset='100%25' style='stop-color:%231E90FF;stop-opacity:1' /%3E%3C/linearGradient%3E%3Cfilter id='glow' x='-50%25' y='-50%25' width='200%25' height='200%25'%3E%3CfeGaussianBlur stdDeviation='2' result='coloredBlur'/%3E%3CfeMerge%3E%3CfeMergeNode in='coloredBlur'/%3E%3CfeMergeNode in='SourceGraphic'/%3E%3C/feMerge%3E%3C/filter%3E%3C/defs%3E%3Crect width='200' height='200' fill='url(%23bgGradient)' /%3E%3Ctext font-family='Optima' x='100' y='100' font-size='80' text-anchor='middle' fill='white'%3EA%3C/text%3E%3Ctext font-family='Optima' x='100' y='150' font-size='24' text-anchor='middle' fill='white'%3EAlphabets%3C/text%3E%3Ctext font-family='Optima' x='100' y='180' font-size='24' text-anchor='middle' fill='white'%3EPlayer%3C/text%3E%3C/svg%3E"));
        0x2::display::update_version<Player>(arg0);
    }

    public(friend) fun set_last_checkin_epoch(arg0: &mut Player, arg1: u64) {
        arg0.last_checkin_epoch = arg1;
    }

    public(friend) fun set_last_mint_epoch(arg0: &mut Player, arg1: u64) {
        arg0.last_mint_epoch = arg1;
    }

    public(friend) fun set_last_purchase_all_alphabets_epoch(arg0: &mut Player, arg1: u64) {
        arg0.last_purchase_all_alphabets_epoch = arg1;
    }

    public(friend) fun set_last_word_creation_epoch(arg0: &mut Player, arg1: u64) {
        arg0.last_word_creation_epoch = arg1;
    }

    public fun set_name(arg0: &mut Player, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public(friend) fun set_nonce(arg0: &mut Player, arg1: u64) {
        arg0.nonce = arg1;
    }

    public(friend) fun set_point_getter(arg0: &mut Player, arg1: bool) {
        arg0.point_getter = arg1;
    }

    public fun to_address(arg0: &Player) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun to_bytes(arg0: &Player) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public(friend) fun uid_mut(arg0: &mut Player) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_consecutive_epochs(arg0: &mut Player, arg1: u64) : u64 {
        if (arg1 > arg0.last_word_creation_epoch) {
            if (arg1 - arg0.last_word_creation_epoch == 1) {
                arg0.consecutive_epochs = arg0.consecutive_epochs + 1;
            } else {
                arg0.consecutive_epochs = 0;
            };
        };
        arg0.consecutive_epochs
    }

    // decompiled from Move bytecode v6
}

