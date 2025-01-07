module 0x57c3c17e259628a0a8d3718c5c4a9826a1410066f18bba6847787f09e41667a9::py_position {
    struct PY_POSITION has drop {
        dummy_field: bool,
    }

    struct PyPosition has store, key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        pt_balance: u64,
        yt_balance: u64,
        yield_token: 0x1::string::String,
        expiry: u64,
        index: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        py_index: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
        accured: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64,
    }

    public fun accured(arg0: &PyPosition) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        arg0.accured
    }

    public fun description(arg0: &PyPosition) : 0x1::string::String {
        arg0.description
    }

    public fun expiry(arg0: &PyPosition) : u64 {
        arg0.expiry
    }

    public fun get_py_amount(arg0: &PyPosition) : (u64, u64) {
        (arg0.pt_balance, arg0.yt_balance)
    }

    public fun index(arg0: &PyPosition) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        arg0.index
    }

    fun init(arg0: PY_POSITION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PY_POSITION>(arg0, arg1);
        let v1 = 0x2::display::new<PyPosition>(&v0, arg1);
        0x2::display::add<PyPosition>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Nemo PT&YT | {yield_token} Pool {expiry}"));
        0x2::display::add<PyPosition>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Nemo PT & YT Position"));
        0x2::display::add<PyPosition>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://app.nemoprotocol.com/api/v1/img/py?objectId={id}"));
        0x2::display::update_version<PyPosition>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PyPosition>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PyPosition {
        PyPosition{
            id          : 0x2::object::new(arg3),
            py_state_id : arg0,
            name        : 0x1::string::utf8(b"Nemo PT&YT"),
            description : 0x1::string::utf8(b"Nemo PT & YT Position"),
            url         : 0x1::string::utf8(b""),
            pt_balance  : 0,
            yt_balance  : 0,
            yield_token : arg1,
            expiry      : arg2,
            index       : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::zero(),
            py_index    : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::zero(),
            accured     : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::zero(),
        }
    }

    public fun name(arg0: &PyPosition) : 0x1::string::String {
        arg0.name
    }

    public fun pt_balance(arg0: &PyPosition) : u64 {
        arg0.pt_balance
    }

    public fun py_expiry(arg0: &PyPosition) : u64 {
        arg0.expiry
    }

    public fun py_index(arg0: &PyPosition) : 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64 {
        arg0.py_index
    }

    public fun py_state_id(arg0: &PyPosition) : 0x2::object::ID {
        arg0.py_state_id
    }

    public fun set_accured(arg0: &mut PyPosition, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) {
        arg0.accured = arg1;
    }

    public(friend) fun set_index(arg0: &mut PyPosition, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) {
        arg0.index = arg1;
    }

    public(friend) fun set_pt_balance(arg0: &mut PyPosition, arg1: u64) {
        arg0.pt_balance = arg1;
    }

    public(friend) fun set_py_index(arg0: &mut PyPosition, arg1: 0x859fffdf878fe3fe1fc8e9765e81a8ec1059a968df2ac0bad250da38819bc972::fixed_point64::FixedPoint64) {
        arg0.py_index = arg1;
    }

    public(friend) fun set_yt_balance(arg0: &mut PyPosition, arg1: u64) {
        arg0.yt_balance = arg1;
    }

    public fun yield_token(arg0: &PyPosition) : 0x1::string::String {
        arg0.yield_token
    }

    public fun yt_balance(arg0: &PyPosition) : u64 {
        arg0.yt_balance
    }

    // decompiled from Move bytecode v6
}

