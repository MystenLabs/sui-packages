module 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::item {
    struct SlotType has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        slot_name: 0x1::string::String,
    }

    struct ItemType has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        slot_name: 0x1::string::String,
        item_name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct TraitType has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        trait_name: 0x1::string::String,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        slot_name: 0x1::string::String,
        item_name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Trait has store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        trait_name: 0x1::string::String,
        trait_value: u64,
    }

    struct SlotTypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        slot_name: 0x1::string::String,
    }

    struct ItemTypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        slot_name: 0x1::string::String,
        membership_type: 0x1::string::String,
        item_name: 0x1::string::String,
    }

    struct ItemKey<phantom T0: store + key> has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        slot_name: 0x1::string::String,
    }

    struct TraitTypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_type: 0x1::string::String,
        trait_name: 0x1::string::String,
    }

    public fun attach_trait_to_item(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut Item, arg2: Trait) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(v0 == arg1.community_id, 13906835033336840191);
        assert!(arg2.community_id == v0, 13906835037631807487);
        let v1 = TraitTypeKey<TraitType>{
            community_id    : v0,
            membership_type : arg1.membership_type,
            trait_name      : arg2.trait_name,
        };
        0x2::dynamic_field::add<TraitTypeKey<TraitType>, Trait>(&mut arg1.id, v1, arg2);
    }

    public fun equip_item_to_membership(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::Membership, arg2: Item, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_membership_name(arg1);
        let v1 = ItemKey<Item>{
            community_id    : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
            membership_type : v0,
            slot_name       : arg2.slot_name,
        };
        if (!0x2::dynamic_object_field::exists_<ItemKey<Item>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_uid_membership(arg1), v1)) {
            let v2 = ItemKey<Item>{
                community_id    : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
                membership_type : v0,
                slot_name       : arg2.slot_name,
            };
            0x2::dynamic_object_field::add<ItemKey<Item>, Item>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg1), v2, arg2);
        } else {
            let v3 = ItemKey<Item>{
                community_id    : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
                membership_type : v0,
                slot_name       : arg2.slot_name,
            };
            let v4 = ItemKey<Item>{
                community_id    : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
                membership_type : v0,
                slot_name       : arg2.slot_name,
            };
            0x2::dynamic_object_field::add<ItemKey<Item>, Item>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg1), v4, arg2);
            0x2::transfer::public_transfer<Item>(0x2::dynamic_object_field::remove<ItemKey<Item>, Item>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg1), v3), 0x2::tx_context::sender(arg3));
        };
    }

    public fun new_item(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Item {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::ItemManager>(arg0, 0x2::tx_context::sender(arg4)), 2);
        let v1 = ItemTypeKey<ItemType>{
            community_id    : v0,
            slot_name       : arg2,
            membership_type : arg1,
            item_name       : arg3,
        };
        Item{
            id              : 0x2::object::new(arg4),
            community_id    : v0,
            membership_type : arg1,
            slot_name       : arg2,
            item_name       : arg3,
            image_url       : 0x2::dynamic_field::borrow_mut<ItemTypeKey<ItemType>, ItemType>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v1).image_url,
        }
    }

    public fun new_item_type(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::ItemManager>(arg0, 0x2::tx_context::sender(arg5)), 2);
        let v1 = SlotTypeKey<SlotType>{
            community_id    : v0,
            membership_type : arg1,
            slot_name       : arg2,
        };
        assert!(0x2::dynamic_field::exists_<SlotTypeKey<SlotType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_uid(arg0), v1), 13906834646789783551);
        let v2 = ItemTypeKey<ItemType>{
            community_id    : v0,
            slot_name       : arg2,
            membership_type : arg1,
            item_name       : arg3,
        };
        assert!(!0x2::dynamic_field::exists_<ItemTypeKey<ItemType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_uid(arg0), v2), 13906834672559587327);
        let v3 = ItemTypeKey<ItemType>{
            community_id    : v0,
            slot_name       : arg2,
            membership_type : arg1,
            item_name       : arg3,
        };
        let v4 = ItemType{
            community_id    : v0,
            membership_type : arg1,
            slot_name       : arg2,
            item_name       : arg3,
            image_url       : arg4,
        };
        0x2::dynamic_field::add<ItemTypeKey<ItemType>, ItemType>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v3, v4);
    }

    public fun new_slot_type(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::ItemManager>(arg0, 0x2::tx_context::sender(arg3)), 2);
        let v1 = SlotTypeKey<SlotType>{
            community_id    : v0,
            membership_type : arg1,
            slot_name       : arg2,
        };
        assert!(!0x2::dynamic_field::exists_<SlotTypeKey<SlotType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_uid(arg0), v1), 13906834543710568447);
        let v2 = SlotTypeKey<SlotType>{
            community_id    : v0,
            membership_type : arg1,
            slot_name       : arg2,
        };
        let v3 = SlotType{
            community_id    : v0,
            membership_type : arg1,
            slot_name       : arg2,
        };
        0x2::dynamic_field::add<SlotTypeKey<SlotType>, SlotType>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v2, v3);
        0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::update_version(arg0);
    }

    public fun new_trait(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Trait {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::ItemManager>(arg0, 0x2::tx_context::sender(arg4)), 2);
        let v1 = TraitTypeKey<TraitType>{
            community_id    : v0,
            membership_type : arg1,
            trait_name      : arg2,
        };
        assert!(0x2::dynamic_field::exists_<TraitTypeKey<TraitType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_uid(arg0), v1), 13906834964617363455);
        Trait{
            community_id    : v0,
            membership_type : arg1,
            trait_name      : arg2,
            trait_value     : arg3,
        }
    }

    public fun new_trait_type(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::ItemManager>(arg0, 0x2::tx_context::sender(arg3)), 2);
        let v1 = TraitTypeKey<TraitType>{
            community_id    : v0,
            membership_type : arg1,
            trait_name      : arg2,
        };
        assert!(!0x2::dynamic_field::exists_<TraitTypeKey<TraitType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_uid(arg0), v1), 13906834762753900543);
        let v2 = TraitTypeKey<TraitType>{
            community_id    : v0,
            membership_type : arg1,
            trait_name      : arg2,
        };
        let v3 = TraitType{
            community_id    : v0,
            membership_type : arg1,
            trait_name      : arg2,
        };
        0x2::dynamic_field::add<TraitTypeKey<TraitType>, TraitType>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v2, v3);
        0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::update_version(arg0);
    }

    public fun unequip_item_from_membership(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::Membership, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_membership_name(arg1);
        let v1 = ItemKey<Item>{
            community_id    : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
            membership_type : v0,
            slot_name       : arg2,
        };
        assert!(0x2::dynamic_object_field::exists_<ItemKey<Item>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg1), v1), 13906835346869452799);
        let v2 = ItemKey<Item>{
            community_id    : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
            membership_type : v0,
            slot_name       : arg2,
        };
        0x2::transfer::public_transfer<Item>(0x2::dynamic_object_field::remove<ItemKey<Item>, Item>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg1), v2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

