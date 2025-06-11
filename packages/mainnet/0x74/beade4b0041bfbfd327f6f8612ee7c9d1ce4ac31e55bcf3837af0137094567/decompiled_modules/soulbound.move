module 0x74beade4b0041bfbfd327f6f8612ee7c9d1ce4ac31e55bcf3837af0137094567::soulbound {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PointsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AnimaSBT has key {
        id: 0x2::object::UID,
        points: u64,
    }

    struct UpdateAnimaPoints has copy, drop {
        anima_sbt_id: 0x2::object::ID,
        to_add: u64,
        total_points: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_anima_sbt(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnimaSBT{
            id     : 0x2::object::new(arg0),
            points : 0,
        };
        0x2::transfer::transfer<AnimaSBT>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_points_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PointsAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PointsAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun update_points(arg0: &PointsAdminCap, arg1: &mut AnimaSBT, arg2: u64) {
        arg1.points = arg1.points + arg2;
        let v0 = UpdateAnimaPoints{
            anima_sbt_id : 0x2::object::uid_to_inner(&arg1.id),
            to_add       : arg2,
            total_points : arg1.points,
        };
        0x2::event::emit<UpdateAnimaPoints>(v0);
    }

    // decompiled from Move bytecode v6
}

