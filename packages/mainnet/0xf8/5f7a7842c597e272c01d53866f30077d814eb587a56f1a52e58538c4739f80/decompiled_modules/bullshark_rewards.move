module 0xf85f7a7842c597e272c01d53866f30077d814eb587a56f1a52e58538c4739f80::bullshark_rewards {
    struct DropList has key {
        id: 0x2::object::UID,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut DropList, arg1: &0x2::transfer_policy::TransferPolicy<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>>, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::to_bytes<vector<address>>(&arg2);
        let v1 = 0x2::dynamic_field::remove_if_exists<address, bool>(&mut arg0.id, 0x2::address::from_bytes(0x2::hash::blake2b256(&v0)));
        assert!(0x1::option::is_some<bool>(&v1), 0);
        while (0x1::vector::length<address>(&arg2) > 0) {
            let (v2, v3) = 0x2::kiosk::new(arg4);
            let v4 = v3;
            let v5 = v2;
            let v6 = 0x2::tx_context::fresh_object_address(arg4);
            let v7 = 0x1::vector::empty<vector<u8>>();
            let v8 = &mut v7;
            0x1::vector::push_back<vector<u8>>(v8, 0x2::bcs::to_bytes<0x2::object::UID>(0x2::kiosk::uid(&v5)));
            0x1::vector::push_back<vector<u8>>(v8, 0x2::bcs::to_bytes<address>(&v6));
            0x1::vector::push_back<vector<u8>>(v8, 0x2::bcs::to_bytes<0x2::clock::Clock>(arg3));
            let v9 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v7);
            let v10 = 0x2::hash::blake2b256(&v9);
            0x2::kiosk::lock<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>>(&mut v5, &v4, arg1, 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::mint<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>(&mut arg0.id, 0, v10, 0xf85f7a7842c597e272c01d53866f30077d814eb587a56f1a52e58538c4739f80::genes_v2::get_attributes<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>(&arg0.id, &v10), arg3, arg4));
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x1::vector::pop_back<address>(&mut arg2));
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        };
    }

    public fun authorize(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut DropList, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<u8>) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::authorize_app<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>(arg0, &mut arg1.id, 0x1::string::utf8(b"bullshark_rewards"), arg2, arg3, arg4, arg5, arg6);
        0xf85f7a7842c597e272c01d53866f30077d814eb587a56f1a52e58538c4739f80::genes_v2::add_gene_definitions<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>(&mut arg1.id, arg7);
    }

    public fun deauthorize(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut DropList) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::revoke_auth<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DropList{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<DropList>(v0);
        let v1 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun setup(arg0: &mut DropList, arg1: SetupCap, arg2: vector<address>) {
        let SetupCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::dynamic_field::add<address, bool>(&mut arg0.id, 0x1::vector::pop_back<address>(&mut arg2), true);
        };
    }

    // decompiled from Move bytecode v6
}

