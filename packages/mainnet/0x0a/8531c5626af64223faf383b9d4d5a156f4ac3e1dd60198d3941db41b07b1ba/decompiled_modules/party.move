module 0xa8531c5626af64223faf383b9d4d5a156f4ac3e1dd60198d3941db41b07b1ba::party {
    struct Balloon has key {
        id: 0x2::object::UID,
        popped: bool,
    }

    public entry fun fill_up_balloon(arg0: &mut 0x2::tx_context::TxContext) {
        new_balloon(arg0);
    }

    public entry fun getPools(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools) : vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id_from_address(@0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, v0, 1000)
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

    public fun pool_id(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo) : 0x2::object::ID {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(arg0)
    }

    public entry fun pop_balloon(arg0: &mut Balloon) {
        arg0.popped = true;
    }

    // decompiled from Move bytecode v6
}

