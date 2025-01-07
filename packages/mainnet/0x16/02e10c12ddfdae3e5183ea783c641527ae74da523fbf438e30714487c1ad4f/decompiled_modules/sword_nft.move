module 0x1602e10c12ddfdae3e5183ea783c641527ae74da523fbf438e30714487c1ad4f::sword_nft {
    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        status: u8,
    }

    struct SwordCreate has copy, drop {
        status: u8,
        sword_id: 0x2::object::ID,
    }

    struct SwordTransfer has copy, drop {
        sword_id: 0x2::object::ID,
        recipient: address,
    }

    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
    }

    struct Forge has store, key {
        id: 0x2::object::UID,
        swords_created: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Forge{
            id             : 0x2::object::new(arg0),
            swords_created : 0,
        };
        0x2::transfer::transfer<Forge>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Outcome{
            game_id : *0x2::object::uid_as_inner(&v0.id),
            status  : 1,
        };
        0x2::event::emit<Outcome>(v1);
    }

    public fun magic(arg0: &Sword) : u64 {
        arg0.magic
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public entry fun sword_create(arg0: &mut Forge, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Sword{
            id       : 0x2::object::new(arg4),
            magic    : arg1,
            strength : arg2,
        };
        arg0.swords_created = arg0.swords_created + 1;
        let v1 = SwordCreate{
            status   : 2,
            sword_id : 0x2::object::id<Sword>(&v0),
        };
        0x2::event::emit<SwordCreate>(v1);
        0x2::transfer::transfer<Sword>(v0, arg3);
    }

    public entry fun sword_transfer(arg0: Sword, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Sword>(arg0, arg1);
        let v0 = SwordTransfer{
            sword_id  : *0x2::object::uid_as_inner(&arg0.id),
            recipient : arg1,
        };
        0x2::event::emit<SwordTransfer>(v0);
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

