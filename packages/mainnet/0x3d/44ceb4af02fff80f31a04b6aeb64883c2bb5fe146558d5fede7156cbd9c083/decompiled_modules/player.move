module 0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::player {
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
        point_balance: 0x2::balance::Balance<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>,
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
            point_balance                     : 0x2::balance::zero<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT>(),
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

    public fun point_balance(arg0: &Player) : &0x2::balance::Balance<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT> {
        &arg0.point_balance
    }

    public(friend) fun point_balance_mut(arg0: &mut Player) : &mut 0x2::balance::Balance<0x3d44ceb4af02fff80f31a04b6aeb64883c2bb5fe146558d5fede7156cbd9c083::point::POINT> {
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
        0x2::display::add<Player>(arg0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22200%22%20height%3D%22200%22%20viewBox%3D%220%200%20200%20200%22%3E%3Cdefs%3E%3ClinearGradient%20id%3D%22bgGradient%22%20x1%3D%220%25%22%20y1%3D%220%25%22%20x2%3D%22100%25%22%20y2%3D%22100%25%22%3E%3Cstop%20offset%3D%220%25%22%20style%3D%22stop-color%3A%234B0082%3Bstop-opacity%3A1%22%2F%3E%3Cstop%20offset%3D%22100%25%22%20style%3D%22stop-color%3A%231E90FF%3Bstop-opacity%3A1%22%2F%3E%3C%2FlinearGradient%3E%3Cfilter%20id%3D%22glow%22%20x%3D%22-50%25%22%20y%3D%22-50%25%22%20width%3D%22200%25%22%20height%3D%22200%25%22%3E%3CfeGaussianBlur%20stdDeviation%3D%222%22%20result%3D%22coloredBlur%22%2F%3E%3CfeMerge%3E%3CfeMergeNode%20in%3D%22coloredBlur%22%2F%3E%3CfeMergeNode%20in%3D%22SourceGraphic%22%2F%3E%3C%2FfeMerge%3E%3C%2Ffilter%3E%3C%2Fdefs%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22url%28%23bgGradient%29%22%2F%3E%3Ctext%20font-family%3D%22Optima%22%20x%3D%22100%22%20y%3D%2290%22%20font-size%3D%2240%22%20text-anchor%3D%22middle%22%20fill%3D%22white%22%3EAlphabets%3C%2Ftext%3E%3Ctext%20font-family%3D%22Optima%22%20x%3D%22100%22%20y%3D%22140%22%20font-size%3D%2240%22%20text-anchor%3D%22middle%22%20fill%3D%22white%22%3EPlayer%3C%2Ftext%3E%3Ctext%20font-family%3D%22Optima%22%20x%3D%2210%22%20y%3D%22185%22%20font-size%3D%2218%22%20text-anchor%3D%22start%22%20dominant-baseline%3D%22auto%22%20fill%3D%22white%22%3E{name}%3C%2Ftext%3E%3C%2Fsvg%3E"));
        0x2::display::add<Player>(arg0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Alphabets Player"));
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

