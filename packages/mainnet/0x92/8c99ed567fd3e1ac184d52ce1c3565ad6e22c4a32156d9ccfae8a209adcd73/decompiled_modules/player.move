module 0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::player {
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
        point_balance: 0x2::balance::Balance<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::point::POINT>,
    }

    public fun id(arg0: &Player) : 0x2::object::ID {
        0x2::object::id<Player>(arg0)
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
            point_balance                     : 0x2::balance::zero<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::point::POINT>(),
        }
    }

    public(friend) fun transfer(arg0: Player, arg1: address) {
        0x2::transfer::transfer<Player>(arg0, arg1);
    }

    public fun consecutive_epochs(arg0: &Player) : u64 {
        arg0.consecutive_epochs
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

    public fun point_balance(arg0: &Player) : &0x2::balance::Balance<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::point::POINT> {
        &arg0.point_balance
    }

    public(friend) fun point_balance_mut(arg0: &mut Player) : &mut 0x2::balance::Balance<0x928c99ed567fd3e1ac184d52ce1c3565ad6e22c4a32156d9ccfae8a209adcd73::point::POINT> {
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

