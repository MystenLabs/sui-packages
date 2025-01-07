module 0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::mine {
    struct Mine has key {
        id: 0x2::object::UID,
        index: u32,
    }

    struct Ore has store, key {
        id: 0x2::object::UID,
        quality: u8,
    }

    fun err_not_allowed_to_exploit_this_mine() {
        abort 0
    }

    public fun exploit(arg0: &mut Mine, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::KapyCrew, arg2: &0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::pickaxe::Pickaxe, arg3: &mut 0x2::tx_context::TxContext) : Ore {
        if (0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::index(arg1) % num_of_mines() != index(arg0)) {
            err_not_allowed_to_exploit_this_mine();
        };
        let v0 = 0x2::object::new(arg3);
        Ore{
            id      : v0,
            quality : ((((0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::pickaxe::tier(arg2) / 2) as u256) + 0x2::address::to_u256(0x2::object::uid_to_address(&v0)) % ((0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::pickaxe::tier(arg2) / 3) as u256)) as u8),
        }
    }

    entry fun exploit_and_transfer(arg0: &mut Mine, arg1: &0xc00d69e58132d45903419bd1734cf0ce6b61352d9eedb241cfd2d0cad32e1de8::kapy_crew::KapyCrew, arg2: &0x40eccc7f6302e74de80f905fe80d3caedd008209a3a503b567be02161248c13d::pickaxe::Pickaxe, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Ore>(exploit(arg0, arg1, arg2, arg4), arg3);
    }

    public fun index(arg0: &Mine) : u32 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < num_of_mines()) {
            let v1 = Mine{
                id    : 0x2::object::new(arg0),
                index : v0,
            };
            0x2::transfer::share_object<Mine>(v1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun melt(arg0: Ore) : u8 {
        let Ore {
            id      : v0,
            quality : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun num_of_mines() : u32 {
        5
    }

    // decompiled from Move bytecode v6
}

