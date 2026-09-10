module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::mob_rows {
    struct MobKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct MobTemplate has key {
        id: 0x2::object::UID,
        data: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::MobData,
    }

    struct MobTemplateCreated has copy, drop {
        template: 0x2::object::ID,
        mob_type: 0x1::string::String,
    }

    public fun add_mob(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::MobData, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::mob_type(&arg2);
        let v1 = MobKey{pos0: v0};
        let v2 = MobTemplate{
            id   : 0x2::derived_object::claim<MobKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg3), v1),
            data : arg2,
        };
        let v3 = MobTemplateCreated{
            template : 0x2::object::uid_to_inner(&v2.id),
            mob_type : v0,
        };
        0x2::event::emit<MobTemplateCreated>(v3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"mobs"), v0, arg3);
        0x2::transfer::share_object<MobTemplate>(v2);
    }

    public fun data(arg0: &MobTemplate) : &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::MobData {
        &arg0.data
    }

    public fun overwrite_mob(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut MobTemplate, arg3: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::MobData, arg4: &0x2::tx_context::TxContext) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::mob_type(&arg3) == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::mob_type(&arg2.data), 4301);
        arg2.data = arg3;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"mobs"), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::mob_type(&arg2.data), arg4);
    }

    // decompiled from Move bytecode v7
}

