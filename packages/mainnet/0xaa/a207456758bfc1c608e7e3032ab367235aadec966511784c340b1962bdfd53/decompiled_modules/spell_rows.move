module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows {
    struct SpellKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct SpellTemplate has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        classe: 0x1::string::String,
        unlock_level: u8,
        levels: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>,
    }

    struct SpellCreated has copy, drop {
        template: 0x2::object::ID,
        name: 0x1::string::String,
        classe: 0x1::string::String,
    }

    public fun add_spell(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>, arg6: &0x2::tx_context::TxContext) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_classe(&arg3), 4401);
        assert!(0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>(&arg5) == 6, 4402);
        let v0 = SpellKey{pos0: arg2};
        let v1 = SpellTemplate{
            id           : 0x2::derived_object::claim<SpellKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg6), v0),
            name         : arg2,
            classe       : arg3,
            unlock_level : arg4,
            levels       : arg5,
        };
        let v2 = SpellCreated{
            template : 0x2::object::uid_to_inner(&v1.id),
            name     : v1.name,
            classe   : v1.classe,
        };
        0x2::event::emit<SpellCreated>(v2);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"spells"), v1.name, arg6);
        0x2::transfer::share_object<SpellTemplate>(v1);
    }

    public fun classe(arg0: &SpellTemplate) : 0x1::string::String {
        arg0.classe
    }

    public fun level_of(arg0: &SpellTemplate, arg1: u64) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel {
        *0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>(&arg0.levels, arg1 - 1)
    }

    public fun max_spell_level(arg0: &SpellTemplate) : u64 {
        0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>(&arg0.levels)
    }

    public fun name(arg0: &SpellTemplate) : 0x1::string::String {
        arg0.name
    }

    public fun overwrite_spell(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut SpellTemplate, arg3: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::spell_effect::SpellLevel>(&arg3) == 6, 4402);
        arg2.levels = arg3;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"spells"), arg2.name, arg4);
    }

    public fun unlock_level(arg0: &SpellTemplate) : u8 {
        arg0.unlock_level
    }

    // decompiled from Move bytecode v7
}

