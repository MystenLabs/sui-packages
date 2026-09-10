module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item {
    struct Item has store, key {
        id: 0x2::object::UID,
        template: 0x2::object::ID,
        name: 0x1::string::String,
        item_type: 0x1::string::String,
        category: 0x1::string::String,
        level: u8,
        amount: u32,
    }

    struct AmountChanged has copy, drop {
        item: 0x2::object::ID,
        amount: u32,
    }

    struct PM has drop {
        template: 0x2::object::ID,
        name: 0x1::string::String,
        item_type: 0x1::string::String,
        category: 0x1::string::String,
        level: u8,
        stats_min: vector<u16>,
        stats_max: vector<u16>,
        damages: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>,
        existing: 0x1::option::Option<0x2::object::ID>,
    }

    struct RolledStats has copy, drop, store {
        statistics: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics,
        puits: u64,
        revision: u64,
    }

    struct StatsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DamagesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ITEM has drop {
        dummy_field: bool,
    }

    public fun amount(arg0: &Item) : u32 {
        arg0.amount
    }

    public(friend) fun assert_distribution(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg1: u32) {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_category(arg0);
        assert!(arg1 == 1 || 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&v0), 202);
        let v1 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::damage_lines(arg0);
        assert!(0x1::vector::is_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>(&v1), 208);
        if (v0 == 0x1::string::utf8(b"pet")) {
            assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::has_stats(arg0), 208);
            assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_min(arg0) == 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_max(arg0), 208);
        } else {
            assert!(!0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::has_stats(arg0), 208);
        };
    }

    public(friend) fun burn(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<Item>, arg3: 0x2::object::ID, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        assert!(arg4 >= 1, 203);
        let v0 = 0x2::kiosk::borrow<Item>(arg0, arg1, arg3).amount;
        assert!(arg4 <= v0, 203);
        if (arg4 < v0) {
            let v2 = 0x2::kiosk::borrow_mut<Item>(arg0, arg1, arg3);
            v2.amount = v2.amount - arg4;
            let v3 = AmountChanged{
                item   : arg3,
                amount : v2.amount,
            };
            0x2::event::emit<AmountChanged>(v3);
            v2.category
        } else {
            let v4 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::extract_from_kiosk<Item>(arg2, arg0, arg1, arg3, arg5);
            destroy(v4);
            v4.category
        }
    }

    public(friend) fun can_merge(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &Item) : bool {
        let v0 = if (!0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg3.category)) {
            true
        } else if (!0x2::kiosk::has_item_with_type<Item>(arg0, arg2)) {
            true
        } else {
            0x2::kiosk::is_listed(arg0, arg2)
        };
        if (v0) {
            return false
        };
        let v1 = 0x2::kiosk::borrow<Item>(arg0, arg1, arg2);
        v1.template == arg3.template && (v1.amount as u64) + (arg3.amount as u64) <= 4294967295
    }

    public fun category(arg0: &Item) : 0x1::string::String {
        arg0.category
    }

    public fun damages(arg0: &Item) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages> {
        let v0 = DamagesKey{dummy_field: false};
        *0x2::dynamic_field::borrow<DamagesKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>>(&arg0.id, v0)
    }

    public(friend) fun deliver_drops(arg0: &mut vector<PM>, arg1: &0x1::string::String, arg2: u32, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<Item>, arg6: &mut 0x2::random::RandomGenerator, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PM>(arg0) && &0x1::vector::borrow<PM>(arg0, v0).item_type != arg1) {
            v0 = v0 + 1;
        };
        let v1 = 0x1::vector::remove<PM>(arg0, v0);
        if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&v1.category)) {
            deposit(arg3, arg4, arg5, v1.existing, mint_from_plan(&v1, arg2, arg6, arg7));
        } else {
            let v2 = 0;
            while (v2 < arg2) {
                deposit(arg3, arg4, arg5, 0x1::option::none<0x2::object::ID>(), mint_from_plan(&v1, 1, arg6, arg7));
                v2 = v2 + 1;
            };
        };
    }

    public(friend) fun deposit(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<Item>, arg3: 0x1::option::Option<0x2::object::ID>, arg4: Item) {
        if (0x1::option::is_some<0x2::object::ID>(&arg3) && can_merge(arg0, arg1, *0x1::option::borrow<0x2::object::ID>(&arg3), &arg4)) {
            let v0 = 0x2::kiosk::borrow_mut<Item>(arg0, arg1, *0x1::option::borrow<0x2::object::ID>(&arg3));
            merge(v0, arg4);
        } else {
            0x2::kiosk::lock<Item>(arg0, arg1, arg2, arg4);
        };
    }

    public(friend) fun destroy(arg0: Item) {
        let v0 = AmountChanged{
            item   : 0x2::object::id<Item>(&arg0),
            amount : 0,
        };
        0x2::event::emit<AmountChanged>(v0);
        let Item {
            id        : v1,
            template  : _,
            name      : _,
            item_type : _,
            category  : _,
            level     : _,
            amount    : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun has_damages(arg0: &Item) : bool {
        let v0 = DamagesKey{dummy_field: false};
        0x2::dynamic_field::exists<DamagesKey>(&arg0.id, v0)
    }

    public fun has_stats(arg0: &Item) : bool {
        let v0 = StatsKey{dummy_field: false};
        0x2::dynamic_field::exists<StatsKey>(&arg0.id, v0)
    }

    fun init(arg0: ITEM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ITEM>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun item_type(arg0: &Item) : 0x1::string::String {
        arg0.item_type
    }

    public fun level(arg0: &Item) : u8 {
        arg0.level
    }

    public(friend) fun merge(arg0: &mut Item, arg1: Item) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg0.category), 202);
        assert!(arg0.template == arg1.template, 204);
        arg0.amount = arg0.amount + arg1.amount;
        let v0 = AmountChanged{
            item   : 0x2::object::id<Item>(arg0),
            amount : arg0.amount,
        };
        0x2::event::emit<AmountChanged>(v0);
        destroy(arg1);
    }

    public(friend) fun mint(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg1: u32, arg2: &mut 0x2::random::RandomGenerator, arg3: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = prepare_plan(arg0, 0x1::option::none<0x2::object::ID>());
        mint_from_plan(&v0, arg1, arg2, arg3)
    }

    public(friend) fun mint_distribution(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Item {
        assert_distribution(arg0, arg1);
        let v0 = prepare_plan(arg0, 0x1::option::none<0x2::object::ID>());
        let v1 = if (0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::has_stats(arg0)) {
            0x1::option::some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_min(arg0))
        } else {
            0x1::option::none<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>()
        };
        mint_resolved_from_plan(&v0, arg1, v1, arg2)
    }

    fun mint_from_plan(arg0: &PM, arg1: u32, arg2: &mut 0x2::random::RandomGenerator, arg3: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = if (!0x1::vector::is_empty<u16>(&arg0.stats_min)) {
            let v1 = vector[];
            let v2 = 0;
            while (v2 < 0x1::vector::length<u16>(&arg0.stats_min)) {
                0x1::vector::push_back<u16>(&mut v1, 0x2::random::generate_u16_in_range(arg2, *0x1::vector::borrow<u16>(&arg0.stats_min, v2), *0x1::vector::borrow<u16>(&arg0.stats_max, v2)));
                v2 = v2 + 1;
            };
            0x1::option::some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::from_vector(v1))
        } else {
            0x1::option::none<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>()
        };
        mint_resolved_from_plan(arg0, arg1, v0, arg3)
    }

    public(friend) fun mint_plain(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Item {
        assert!(!0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::has_stats(arg0), 207);
        let v0 = prepare_plan(arg0, 0x1::option::none<0x2::object::ID>());
        mint_resolved_from_plan(&v0, arg1, 0x1::option::none<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(), arg2)
    }

    fun mint_resolved_from_plan(arg0: &PM, arg1: u32, arg2: 0x1::option::Option<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>, arg3: &mut 0x2::tx_context::TxContext) : Item {
        assert!(arg1 >= 1, 203);
        if (arg1 > 1) {
            assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg0.category), 202);
        };
        let v0 = Item{
            id        : 0x2::object::new(arg3),
            template  : arg0.template,
            name      : arg0.name,
            item_type : arg0.item_type,
            category  : arg0.category,
            level     : arg0.level,
            amount    : arg1,
        };
        if (0x1::option::is_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(&arg2)) {
            let v1 = StatsKey{dummy_field: false};
            let v2 = RolledStats{
                statistics : 0x1::option::destroy_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics>(arg2),
                puits      : 0,
                revision   : 0,
            };
            0x2::dynamic_field::add<StatsKey, RolledStats>(&mut v0.id, v1, v2);
        };
        if (!0x1::vector::is_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>(&arg0.damages)) {
            let v3 = DamagesKey{dummy_field: false};
            0x2::dynamic_field::add<DamagesKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages::ItemDamages>>(&mut v0.id, v3, arg0.damages);
        };
        v0
    }

    public(friend) fun prepare_plan(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg1: 0x1::option::Option<0x2::object::ID>) : PM {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::has_stats(arg0);
        let v1 = if (v0) {
            let v2 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_min(arg0);
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&v2)
        } else {
            vector[]
        };
        let v3 = if (v0) {
            let v4 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_max(arg0);
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_vector(&v4)
        } else {
            vector[]
        };
        PM{
            template  : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg0),
            name      : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_name(arg0),
            item_type : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg0),
            category  : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_category(arg0),
            level     : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_level(arg0),
            stats_min : v1,
            stats_max : v3,
            damages   : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::damage_lines(arg0),
            existing  : arg1,
        }
    }

    public fun puits(arg0: &Item) : u64 {
        let v0 = StatsKey{dummy_field: false};
        0x2::dynamic_field::borrow<StatsKey, RolledStats>(&arg0.id, v0).puits
    }

    public(friend) fun set_stats(arg0: &mut Item, arg1: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics, arg2: u64) {
        let v0 = StatsKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<StatsKey, RolledStats>(&mut arg0.id, v0);
        let v2 = RolledStats{
            statistics : arg1,
            puits      : arg2,
            revision   : v1.revision + 1,
        };
        *v1 = v2;
    }

    public(friend) fun split(arg0: &mut Item, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : Item {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg0.category), 202);
        assert!(arg1 >= 1, 203);
        assert!(arg0.amount > arg1, 203);
        arg0.amount = arg0.amount - arg1;
        let v0 = AmountChanged{
            item   : 0x2::object::id<Item>(arg0),
            amount : arg0.amount,
        };
        0x2::event::emit<AmountChanged>(v0);
        Item{
            id        : 0x2::object::new(arg2),
            template  : arg0.template,
            name      : arg0.name,
            item_type : arg0.item_type,
            category  : arg0.category,
            level     : arg0.level,
            amount    : arg1,
        }
    }

    public fun stats(arg0: &Item) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::ItemStatistics {
        let v0 = StatsKey{dummy_field: false};
        0x2::dynamic_field::borrow<StatsKey, RolledStats>(&arg0.id, v0).statistics
    }

    public fun template(arg0: &Item) : 0x2::object::ID {
        arg0.template
    }

    public(friend) fun uid(arg0: &Item) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Item) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

