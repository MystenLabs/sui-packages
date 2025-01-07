module 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    struct EquipmentReceipt {
        equips: vector<0x2::object::ID>,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public(friend) fun add_id_to_receipt(arg0: &mut EquipmentReceipt, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.equips, arg1);
    }

    public fun confirm_equipped_attribute<T0>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &mut EquipmentReceipt) {
        let v0 = 0x2::transfer_policy::item<T0>(arg0);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg1.equips, &v0);
        assert!(v1, 0);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.equips, v2);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg0);
    }

    public(friend) fun destroy_empty_receipt(arg0: EquipmentReceipt) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.equips) == 0, 0);
        let EquipmentReceipt {  } = arg0;
    }

    public(friend) fun new_receipt() : EquipmentReceipt {
        EquipmentReceipt{equips: 0x1::vector::empty<0x2::object::ID>()}
    }

    // decompiled from Move bytecode v6
}

