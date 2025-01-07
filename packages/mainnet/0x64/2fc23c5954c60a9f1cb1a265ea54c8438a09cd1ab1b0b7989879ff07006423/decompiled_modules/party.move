module 0x642fc23c5954c60a9f1cb1a265ea54c8438a09cd1ab1b0b7989879ff07006423::party {
    struct FetchPoolsEvent has copy, drop, store {
        pools: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>,
    }

    struct Balloon has key {
        id: 0x2::object::UID,
        popped: bool,
    }

    public entry fun fill_up_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    public entry fun getPools(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id_from_address(@0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630));
        let v1 = FetchPoolsEvent{pools: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, v0, 1000)};
        0x2::event::emit<FetchPoolsEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    fun new_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Balloon{
            id     : 0x2::object::new(arg0),
            popped : false,
        };
        0x2::transfer::share_object<Balloon>(v0);
    }

    public entry fun pop_balloon(arg0: &mut Balloon) {
        arg0.popped = true;
    }

    // decompiled from Move bytecode v6
}

