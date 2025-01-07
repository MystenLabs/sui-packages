module 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map {
    struct Map has copy, drop, store {
        level: u64,
        enable: bool,
        time: u64,
        reset: u64,
        data: vector<vector<u8>>,
    }

    public fun create_map(arg0: vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) : Map {
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 16, 0);
        Map{
            level  : 1,
            enable : true,
            time   : 0,
            reset  : 0,
            data   : arg0,
        }
    }

    public fun data(arg0: &Map) : &vector<vector<u8>> {
        &arg0.data
    }

    public fun enable(arg0: &Map) : bool {
        arg0.enable
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun level(arg0: &Map) : u64 {
        arg0.level
    }

    public fun reset(arg0: &Map) : u64 {
        arg0.reset
    }

    public fun time(arg0: &Map) : u64 {
        arg0.time
    }

    public fun update_data(arg0: &mut Map, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 16, 0);
        arg0.data = arg1;
    }

    public fun update_detail(arg0: &mut Map, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.level = arg1;
        arg0.enable = arg2;
        arg0.time = arg3;
        arg0.reset = arg4;
    }

    public fun update_enable(arg0: &mut Map, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.enable = arg1;
    }

    public fun update_level(arg0: &mut Map, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.level = arg1;
    }

    public fun update_reset(arg0: &mut Map, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.time = arg1;
    }

    public fun update_time(arg0: &mut Map, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.time = arg1;
    }

    // decompiled from Move bytecode v6
}

